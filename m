Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483C1B1BCB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2020 04:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDUCXK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 22:23:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDUCXK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 22:23:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2746DAED2;
        Tue, 21 Apr 2020 02:23:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jan Kara <jack@suse.cz>
Date:   Tue, 21 Apr 2020 12:22:59 +1000
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 V3] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <20200416151906.GQ23739@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87ftdgw58w.fsf@notabene.neil.brown.name> <87wo6gs26e.fsf@notabene.neil.brown.name> <87tv1ks24t.fsf@notabene.neil.brown.name> <20200416151906.GQ23739@quack2.suse.cz>
Message-ID: <87zhb5r30c.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16 2020, Jan Kara wrote:

> On Thu 16-04-20 10:30:42, NeilBrown wrote:
>>=20
>> PF_LESS_THROTTLE exists for loop-back nfsd (and a similar need in the
>> loop block driver and callers of prctl(PR_SET_IO_FLUSHER)), where a
>> daemon needs to write to one bdi (the final bdi) in order to free up
>> writes queued to another bdi (the client bdi).
>>=20
>> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
>> pages, so that it can still dirty pages after other processses have been
>> throttled.
>>=20
>> This approach was designed when all threads were blocked equally,
>> independently on which device they were writing to, or how fast it was.
>> Since that time the writeback algorithm has changed substantially with
>> different threads getting different allowances based on non-trivial
>> heuristics.  This means the simple "add 25%" heuristic is no longer
>> reliable.
>>=20
>> The important issue is not that the daemon needs a *larger* dirty page
>> allowance, but that it needs a *private* dirty page allowance, so that
>> dirty pages for the "client" bdi that it is helping to clear (the bdi for
>> an NFS filesystem or loop block device etc) do not affect the throttling
>> of the deamon writing to the "final" bdi.
>>=20
>> This patch changes the heuristic so that the task is only throttled if
>> *both* the global threshhold *and* the per-wb threshold are exceeded.
>> This is similar to the effect of BDI_CAP_STRICTLIMIT which causes the
>> global limits to be ignored, but it isn't as strict.  A PF_LOCAL_THROTTLE
>> task will be allowed to proceed unthrottled if the global threshold is
>> not exceeded or if the local threshold is not exceeded.  They need to
>> both be exceeded before PF_LOCAL_THROTTLE tasks are throttled.
>>=20
>> This approach of "only throttle when target bdi is busy" is consistent
>> with the other use of PF_LESS_THROTTLE in current_may_throttle(), were
>> it causes attention to be focussed only on the target bdi.
>>=20
>> So this patch
>>  - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
>>  - removes the 25% bonus that that flag gives, and
>>  - If PF_LOCAL_THROTTLE is set, don't delay at all unless both
>>    thresholds are exceeded.
>>=20
>> Note that previously realtime threads were treated the same as
>> PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
>> real-time threads, so it is now different from the behaviour of nfsd and
>> loop tasks.  I don't know what is wanted for realtime.
>>=20
>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>> Signed-off-by: NeilBrown <neilb@suse.de>
>
> ...
>
>> @@ -1700,6 +1699,17 @@ static void balance_dirty_pages(struct bdi_writeb=
ack *wb,
>>  				sdtc =3D mdtc;
>>  		}
>>=20=20
>> +		if (current->flags & PF_LOCAL_THROTTLE)
>> +			/* This task must only be throttled based on the bdi
>> +			 * it is writing to - dirty pages for other bdis might
>> +			 * be pages this task is trying to write out.  So it
>> +			 * gets a free pass unless both global and local
>> +			 * thresholds are exceeded.  i.e unless
>> +			 * "dirty_exceeded".
>> +			 */
>> +			if (!dirty_exceeded)
>> +				break;
>> +
>>  		if (dirty_exceeded && !wb->dirty_exceeded)
>>  			wb->dirty_exceeded =3D 1;
>
> Ok, but note that this will have one sideeffect you maybe didn't realize:
> Currently we try to throttle tasks softly - the heuristic rougly works li=
ke
> this: If dirty < (thresh + bg_thresh)/2, leave the task alone.
> (thresh+bg_thresh)/2 is called "freerun ceiling". If dirty is greater than
> this, we delay the task somewhat (the aim is to delay the task as long as
> it would take to write back the pages task has dirtied) in
> balance_dirty_pages() so ideally 'thresh' is never hit. Only if the
> heuristic consistently underestimates the time to writeback pages, we hit
> 'thresh' and then block the task as long as it takes flush worker to clean
> enough pages to get below 'thresh'. This all leads to task being usually
> gradually slowed down in balance_dirty_pages() which generally leads to
> smoother overall system behavior.
>
> What you did makes PF_LOCAL_THROTTLE tasks ignore any limits and then when
> local bdi limit is exceeded, they'll suddently hit the wall and be blocked
> for a long time in balance_dirty_pages().
>
> So I like what you suggest in principle, just I think the implementation
> has undesirable sideeffects. I think it would be better to modify
> wb_position_ratio() to take PF_LOCAL_THROTTLE into account. It will be
> probably similar to how BDI_CAP_STRICTLIMIT is handled but different in
> some ways because BDI_CAP_STRICTLIMIT takes minimum from wb_pos_ratio and
> global pos_ratio, you rather want to take wb_pos_ratio only. Also there a=
re
> some early bail out conditions when we are over global dirty limit which
> you need to handle differently for PF_LOCAL_THROTTLE. And then, when you
> have appropriate pos_ratio computed based on your policy, you can let the
> task wait for appropriate amount of time and things should just work (TM)=
 ;).
> Thinking about it, you probably also want to add 'freerun' condition for
> PF_LOCAL_THROTTLE tasks like:
>
> 	if ((current->flags & PF_LOCAL_THROTTLE) &&
> 	    wb_dirty <=3D dirty_freerun_ceiling(wb_thresh, wb_bg_thresh))
> 		go the freerun path...
>

Thanks.....
I have 2 thoughts on this.
One is that I'm not sure how much it really matters.
The PF_LOCAL_THROTTLE task it always doing writeout on behalf of some
other process.  Some process writes to NFS or to a loop block device or
somewhere, then the PF_LOCAL_THROTTLE task writes those dirty pages out
to a different BDI.  So the top level task will be throttled, an the
PF_LOCAL_THROTTLE task won't get more than it can handle.
There will be starting transients of course, but I doubt it would
generally be a problem.  However it would still be nice to find the
"right" solution.

My second thought is that I really don't understand the writeback code.
I think I understand the general principle, and there are lots of big
comments that try to explain things, but it just doesn't seem to help.
I look at the code and see more questions than answers.

What are the units for "dirty_ratelimit"??  I think it is pages per
second, because it is initialized to INIT_BW which is documented as 100
MB/s.
What is the difference between dirty_ratelimit and
balanced_dirty_ratelimit?
The later is "balanced" I guess.  What does that mean?
Apparently (from backing-dev-defs.h) dirty_ratelimit moves in smaller
steps and is more smooth than balanced_dirty_ratelimit.  How is being
less smooth, more balanced??

What is pos_ratio? And what is RATELIMIT_CALC_SHIFT ???
Maybe pos_ratio is the ratio of the actual number of dirty pages to the
desired number?  And pos_ratio is calculated with fixed-point arithmetic
and RATELIMIT_CALC_SHIFT tells where the point is?

I think I understand freerun - half way between the dirty limit and the
dirty_bg limit.  Se below dirty_bg, no writeback happens.  Between there
and freerun, writeback happens, but nothing in throttled.  From free up
to the limit, tasks are progressively throttled.
"setpoint" is the midpoint of this range.  Is the goal that pos_ratio is
computed for.
(except that in the BDI_CAP_STRICTLIMIT part of wb_position_ratio)
wb_setpoint is set to the bottom of this range, same as the freerun ceiling=
.)

Then we have the control lines, which are cubic(?) for global counts and
linear for per-wb - but truncated at 1/4.  The comment says "so that
wb_dirty can be smoothly throttled".  It'll take me a while to work out
what a hard edge results in smooth throttling.  I suspect it makes sense
but it doesn't jump out at me.

So, you see, I don't feel at all confident changing any of this code
because I just don't get it.

So I'm inclined to stick with the patch that I have. :-(

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6eWQMACgkQOeye3VZi
gblzmBAAv0JCPo9cYL92s4vDZO0QGJEHydlEgTjPzD+k3vuuoreOiRDqdPpurl8S
agmSfGMpkuhMB3yz2+Lo+dRBuevoioFGLMh7JM1KqMPWv5WywkcFZ4NIRdA+FY0y
EatTSNFaFiz+AJ6xINUAUrqkztwnnmh6mRIgay/HxUsXCMG04toF9lVj8nasHpmI
YiABKKTn77kl7Onca2eIYqvEzx97E6VY81zApf6MrYUXUjGrND1BsJz1Mkmx7zB3
Dvkkm4f6f0sJf/1B1MkjHtlsi3AwBp4KSuOOOrzCXDkDR6mlEwUL+4bxjjg2UbJ9
G9T63c3EjZxXik45M3MthcAsBdfq2rbxfz3hfr1gmSBLqbWuC4YDx0qUu49J7URM
3iMB5pNM/fOsa4r6l7gNA2Rt8PBUv1zZfDPslCtapNqWiqAfnlWDhYazs6HHSEax
1m33WXSh76IJNsPzrNv82WIhc0skLrT33SgXUyPOojyQj8xTgpUk7ODoBtmdlHvP
21cLGOuumK7335hkDcc6JrANcVuUeHBqbhewn2w91JWf+GopALU6T29kZ1yB+lA1
BBmgEXYEqqs2pJPEoRiWgqTxPpAi9tcitb31TMfkhft1i2CIqhz8PfeXrkSgycom
xXtSAjyKOLXo+Ct5gMyFckV8XwaW44i46EXBM86AaEdYyrSpm0E=
=2si8
-----END PGP SIGNATURE-----
--=-=-=--
