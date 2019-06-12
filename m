Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAEEA447E3
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfFMRCu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 13:02:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729495AbfFLXD5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 19:03:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC31FAD7F;
        Wed, 12 Jun 2019 23:03:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 13 Jun 2019 09:03:46 +1000
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <FAC8BAC4-5219-4B04-891F-FB640A010857@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name> <3B887552-91FB-493A-8FDF-411562811B36@oracle.com> <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com> <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com> <877e9rwuy5.fsf@notabene.neil.brown.name> <FAC8BAC4-5219-4B04-891F-FB640A010857@oracle.com>
Message-ID: <87tvcuv225.fsf@notabene.neil.brown.name>
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

On Wed, Jun 12 2019, Chuck Lever wrote:

> Hi Neil-
>
>> On Jun 11, 2019, at 7:42 PM, NeilBrown <neilb@suse.com> wrote:
>>=20
>> On Tue, Jun 11 2019, Chuck Lever wrote:
>>=20
>>>=20
>>> Earlier in this thread, Neil proposed to make nconnect a hint. Sounds
>>> like the long term plan is to allow "up to N" connections with some
>>> mechanism to create new connections on-demand." maxconn fits that idea
>>> better, though I'd prefer no new mount options... the point being that
>>> eventually, this setting is likely to be an upper bound rather than a
>>> fixed value.
>>=20
>> When I suggested making at I hint, I considered and rejected the the
>> idea of making it a maximum.  Maybe I should have been explicit about
>> that.
>>=20
>> I think it *is* important to be able to disable multiple connections,
>> hence my suggestion that "nconnect=3D1", as a special case, could be a
>> firm maximum.
>> My intent was that if nconnect was not specified, or was given a larger
>> number, then the implementation should be free to use however many
>> connections it chose from time to time.  The number given would be just
>> a hint - maybe an initial value.  Neither a maximum nor a minimum.
>> Maybe we should add "nonconnect" (or similar) to enforce a single
>> connection, rather than overloading "nconnect=3D1"
>
> So then I think, for the immediate future, you want to see nconnect=3D
> specify the exact number of connections that will be opened. (later
> it can be something the client chooses automatically). IIRC that's
> what Trond's patches already do.
>
> Actually I prefer that the default behavior be the current behavior,
> where the client uses one connection per client-server pair. That
> serves the majority of use cases well enough. Saying that default is
> nconnect=3D1 is then intuitive to understand.
>
> At some later point if we convince ourselves that a higher default
> is safe (ie, does not result in performance regressions in some cases)
> then raise the default to nconnect=3D2 or 3.
>
> I'm not anxious to allow everyone to open an unlimited number of
> connections just yet. That has all kinds of consequences for servers,
> privileged port consumption, etc, etc. I'm not wont to hand an
> unlimited capability to admins who are not NFS-savvy in the name of
> experimentation. That will just make for more phone calls to our
> support centers and possibly some annoyed storage administrators.
> And it seems like something that can be abused pretty easily by
> certain ne'er-do-wells.

I'm sorry, but this comes across to me as very paternalistic.
It is not our place to stop people shooting themselves in the foot.
It *is* our place to avoid security vulnerabilities, but not to prevent
a self-inflicted denial of service.

And no-one is suggesting unlimited (even Solaris limits clnt_max_conns to
2^31-1).  I'm suggesting 256.
If you like, we can make the limit a module parameter so distros can
easily tune it down.  But I'm strongly against imposing a hard limit of
4 or even 8.

>
> Starting with a maximum of 3 or 4 is conservative yet exposes immediate
> benefits. The default connection behavior remains the same. No surprises
> when a stock Linux NFS client is upgraded to a kernel that supports
> nconnect.
>
> The maximum setting can be raised once we understand the corner cases,
> the benefits, and the pitfalls.

I'm quite certain that some customers will have much more performant
hardware than any of us might have in the lab.  They will be the ones to
reap the benefits and find the corner cases and pitfalls.  We need to let
them.

>
>
>> You have said elsewhere that you would prefer configuration in a config
>> file rather than as a mount option.
>> How do you imagine that configuration information getting into the
>> kernel?
>
> I'm assuming Trond's design, where the kernel RPC client upcalls to
> a user space agent (a new daemon, or request-key).
>
>
>> Do we create /sys/fs/nfs/something?  or add to /proc/sys/sunrpc
>> or /proc/net/rpc .... we have so many options !!
>> There is even /sys/kernel/debug/sunrpc/rpc_clnt, but that is not
>> a good place for configuration.
>>=20
>> I suspect that you don't really have an opinion, you just don't like the
>> mount option.  However I don't have that luxury.  I need to put the
>> configuration somewhere.  As it is per-server configuration the only
>> existing place that works at all is a mount option.
>> While that might not be ideal, I do think it is most realistic.
>> Mount options can be deprecated, and carrying support for a deprecated
>> mount option is not expensive.
>
> It's not deprecation that worries me, it's having to change the
> mount option; and the fact that we already believe it will have to
> change makes it especially worrisome that we are picking the wrong
> horse at the start.
>
> NFS mount options will appear in automounter maps for a very long
> time. They will be copied to other OSes. Deprecation is more
> expensive than you might at first think.

automounter maps are a good point .... if this functionality isn't
supported as a mount option, how does someone who uses automounter maps
roll it out?

>
>
>> The option still can be placed in a per-server part of
>> /etc/nfsmount.conf rather than /etc/fstab, if that is what a sysadmin
>> wants to do.
>
> I don't see that having a mount option /and/ a configuration file
> addresses Trond's concern about config pulverization. It makes it
> worse, in fact. But my fundamental problem is with a per-server
> setting specified as a per-mount option. Using a config file is
> just a possible way to address that problem.
>
> For a moment, let's turn the mount option idea on its head. Another
> alternative would be to make nconnect into a real per-mount setting
> instead of a per-server setting.
>
> So now each mount gets to choose the number of connections it is
> permitted to use. Suppose we have three concurrent mounts:
>
>    mount -o nconnect=3D3 server1:/export /mnt/one
>    mount server2:/export /mnt/two
>    mount -o nconnect=3D2 server3:/export /mnt/three
>
> The client opens the maximum of the three nconnect values, which
> is 3. Then:
>
> Traffic to server2 may use only one of these connections. Traffic
> to server3 may use no more than two of those connections. Traffic
> to server1 may use all three of those connections.
>
> Does that make more sense than a per-server setting? Is it feasible
> to implement?

If the servers are distinct, then the connections to them must be
distinct, so no sharing happens here.

But I suspect you meant to have three mounts from the same server, each
with different nconnect values.
So 3 connections are created:
  /mnt/one is allowed all of them
  /mnt/two is allowed to use only one
  /mnt/three is allowed to use only two

Which one or two?  Can /mnt/two use any one as long as it only uses one
at a time, or must it choose one up front and stick to that?
Can /mnt/three arrange to use the two that /mnt/two isn't using?

I think the easiest, and possibly most obvious, would be that each used
the "first" N connections.  So the third connection would only ever be
used by /mnt/one.  Load-balancing would be interesting, but not
impossible.  It might lead to /mnt/one preferentially using the third
connection because it has exclusive access.

I don't think this complexity gains us anything.

A different approach would be have the number of connections to each
server be the maximum number that any mount requested.  Then all mounts
use all connections.

So when /mnt/one is mounted, three connections are established, and they
are all used by /mnt/two and /mnt/three.  But if /mnt/one is unmounted,
then the third connection is closed (once it becomes idle) and /mnt/two
and /mnt/three continue using just two connections.

Adding a new connection is probably quite easy.  Deleting a connection
is probably a little less straight forward, but should be manageable.

How would you feel about that approach?

Thanks,
NeilBrown


>
>
> --
> Chuck Lever

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0BhNIACgkQOeye3VZi
gblTTQ/+OgA0GfLolWbhtTfqlj2qzGcpaskrRVZ/1+ylcG8Mz8uEFRDZhSflzQCY
SHTwizRXzIkJ4xiBQMTkVlwGYvGknmaJHp3tSmEITrYOja9HA+ls/XocdeYiwJbw
g9U1AmP5fvtgln+tBWQXYFsdJsxqvRhNTD0/cUt5x9gzty5JtKS/Gwlr8LE9zbQ6
Qskv0c+5UqsZGAbxxHGC/IDpJxqSWiu3A+WUY3yNtICv0xHcSBRW7NAMpMEVSoQ+
ZDasuCi4x0cjH1GZwpwB/PTFHeoppfe9tsCGCS9wU0zNCIFVRXLMYZ9EB5KmyA+f
gPbCeZR+/4Q9FXRiZskrpK9fCemUqDsDm1q2yQhKAvoEjhatzz5jQ1KlNDMy1Eio
6uPDS9ht7QNj43reXTCl+hZdKslvHA9ftPRk+3e66/g2gIBpQGsLoRSjIugsZ/xx
MUg9wbQ0ESyt6naK2pZr/aGXFjgVDNRb7yew2ZBdmFczM4lVmon6n98R20ZcD6dM
6kh5IK1Yun+NUP8JbHhKRPJnEyGEoSjUiaqmPGEKIHzaLPCVHwEa8B+2aTvWe6lZ
EDgBd/6dUwJ37vE9fWNYKDasPMRJ6M4msHgEWIfSqP0fpKy36KOoSryLPjoZjVTP
B93HErSca8jh+4c12xIaNuE0y4j5mkwme8JfW48BG4NY5wW/j4E=
=Y0SZ
-----END PGP SIGNATURE-----
--=-=-=--
