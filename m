Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32A1E9B86
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 04:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFACBP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 May 2020 22:01:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgFACBP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 31 May 2020 22:01:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEFD7AD41;
        Mon,  1 Jun 2020 02:01:14 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Mon, 01 Jun 2020 12:01:07 +1000
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfs4_show_superblock considered harmful :-)
In-Reply-To: <20200529220608.GA22758@fieldses.org>
References: <871rn38suc.fsf@notabene.neil.brown.name> <20200529220608.GA22758@fieldses.org>
Message-ID: <87a71n7dek.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, May 29 2020, J. Bruce Fields wrote:

> On Fri, May 29, 2020 at 10:53:15AM +1000, NeilBrown wrote:
>>  I've received a report of a 5.3 kernel crashing in
>>  nfs4_show_superblock().
>>  I was part way through preparing a patch when I concluded that
>>  the problem wasn't as straight forward as I thought.
>>
>>  In the crash, the 'struct file *' passed to nfs4_show_superblock()
>>  was NULL.
>>  This file was acquired from find_any_file(), and every other caller
>>  of find_any_file() checks that the returned value is not NULL (though
>>  one BUGs if it is NULL - another WARNs).
>>  But nfs4_show_open() and nfs4_show_lock() don't.
>>  Maybe they should.  I didn't double check, but I suspect they don't
>>  hold enough locks to ensure that the files don't get removed.
>
> I think the only lock held is cl_lock, acquired in states_start.
>
> We're starting here with an nfs4_stid that was found in the cl_stateids
> idr.
>
> A struct nfs4_stid is freed by nfs4_put_stid(), which removes it from
> that idr under cl_lock before freeing the nfs4_stid and anything it
> points to.
>
> I think that was the theory....
>
> One possible problem is downgrades, like nfs4_stateid_downgrade.
>
> I'll keep mulling it over, thanks.

I had another look at code and maybe move_to_close_lru() is the problem.
It can clear remove the files and clear sc_file without taking
cl_lock.  So some protection is needed against that.

I think that only applies to nfs4_show_open() - not show_lock etc.
But I wonder it is might be best to include some extra protection
for each different case, just in case some future code change
allow sc_file to become NULL before the state is detached.

I'd feel more comforatable about nfs4_show_superblock() if it ignored
nf_inode and just used nf_file - it is isn't NULL.  It looks like it
can never be set from non-NULL to NULL.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7UYWMACgkQOeye3VZi
gbnCQA//dMvvn00/vHc6ViAvWw7pxcNGez2H1DKkCym2NlR/sMiNQ1Fg0y+BSRk1
7cAa3FgbozAZu2qFREPFbjYJhrWEVJaWmXjnsRFGTvoe/IaR7o3Zzp9zYgRoydxo
Xy4bbLHo3ZaDUrHHf858FACxmYEMeDJTLWZ7jsDQT9GD4vVhFfjlHM1v2JyelJIE
mJjgM320iQY3azBAys+M4vWfjxNXPuk0Q7gg+TUALqSEZ1leVJOshmxLNZnZC+09
wVYN2sPWwv/cotFeIUCx/tCwlpMU4s6446IDuK8kckI68ugApAyx4hFOsPBtCZ//
kI0xbDUT/VBMsc8Ywpr847i9FPma2YocXwT5RRoBCy7cD11KAlbJTg2ha5cug+FN
fe7HK5g/VqGW2UuP/prQy5Smeygt/PMdEtTsXVMSeQpQYToUUyuM8ZrIz4oCIwEj
JS85ehe7ftB0J1cdnOY5sqBeqzCAr7Yk27rBWZXT7zXcn1SVFfSWmnouyqwzVVcO
MulyPObViPwlXA7qEBqVUgk4B96e+0rQ4r+S8ENlhrpL5JK2fGQ40ho+q1kPBenh
p/wapgxLXfW1nyXaEEAGwdYWUV4lwIHmgXAcnleJMF2SBrt2WO+ZGT+6KodV4RkE
aQ3mzlSg9otIccPaper+oDn5OLCDT7QEwZaCvrKkJ0yLn8uTeRM=
=/MNw
-----END PGP SIGNATURE-----
--=-=-=--
