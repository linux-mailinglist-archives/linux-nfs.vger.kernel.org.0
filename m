Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6E64FF34
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiLRPC0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRPCZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 10:02:25 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Dec 2022 07:02:23 PST
Received: from static.213-239-213-133.clients.your-server.de (luckmann.name [213.239.213.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6312E2BD5
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 07:02:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E62051.00000000639F2A4E.000058EF; Sun, 18 Dec 2022 15:57:18 +0100
Date:   Sun, 18 Dec 2022 15:57:18 +0100
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     linux-nfs@vger.kernel.org
Subject: Issues in man pages of nfs
Message-ID: <20221218145718.GA22740@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-22767-1671375438-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_05,CK_HELO_GENERIC,
        HELO_DYNAMIC_IPADDR,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-22767-1671375438-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear nfs maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including NFS) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
the latest upstream version once in a while, so the error might be
already fixed. We apologize and ask you to close the issue immediately
if this should be the case, but given the huge volume of projects and
the very limited number of volunteers we are not able to double check
each and every issue.

Secondly we translators see the manpages in the neutral po format,
i.e. converted and harmonized, but not the original source (be it man,
groff, xml or other). So we cannot provide a true patch (where
possible), but only an approximation which you need to convert into
your source format.

Finally the issues I'm reporting have accumulated over time and are
not always discovered by me, so sometimes my description of the
problem my be a bit limited - do not hesitate to ask so we can clarify
them.

I'm now reporting the errors for your project. If future reports
should use another channel, please let me know.

Man page: blkmapd.8
Issue:    Markup of device-mapper

"The topology typically consists of a hierarchy of volumes built by stripin=
g, "
"slicing, and concatenating the simple volumes.  The B<blkmapd> daemon uses=
 "
"the device-mapper driver to construct logical devices that reflect the "
"server topology, and passes these devices to the kernel for use by the pNF=
S "
"block layout client."
--
Man page: blkmapd.8
Issue:    Markup of syslogd

"Runs B<blkmapd> in the foreground and sends output to stderr (as opposed t=
o "
"syslogd)"
--
Man page: exportfs.8
Issue:    missing period at the end of sentence

"B<exportfs> will also recognize the B<state-directory-path> value from bot=
h "
"the B<[mountd]> section and the B<[exportd]> section"
--
Man page: exportfs.8
Issue:    B<exports(5)> =E2=86=92 B<exports>(5)

"The I<host:/path> argument specifies a local directory to export, along wi=
th "
"the client or clients who are permitted to access it.  See B<exports(5)> f=
or "
"a description of supported options and access list formats."
--
Man page: nfs.5
Issue:    Why is the word "option" in bold?

"The B<sloppy> option is an alternative to specifying B<mount.nfs> -s "
"B<option.>"
--
Man page: nfs.5
Issue:    B<nfsmount.conf(5)> =E2=86=92 B<nfsmount.conf>(5)

"If the mount command is configured to do so, all of the mount options "
"described in the previous section can also be configured in the I</etc/"
"nfsmount.conf> file. See B<nfsmount.conf(5)> for details."
--
Man page: nfs.5
Issue:    mount option. =E2=86=92 ""

"mount option.  To mount using NFS version 3, use the B<nfs> file system ty=
pe "
"and specify the B<nfsvers=3D3> mount option.  To mount using NFS version 4=
, "
"use either the B<nfs> file system type, with the B<nfsvers=3D4> mount opti=
on, "
"or the B<nfs4> file system type."
--
Man page: nfs.5
Issue:    kernel_soruce

"Enable/Disables the cache of (read-only) data pages to the local disk usin=
g "
"the FS-Cache facility. See cachefilesd(8)  and E<lt>kernel_soruceE<gt>/"
"Documentation/filesystems/caching for detail on how to configure the FS-"
"Cache facility.  Default value is nofsc."
--
Man page: nfs.conf.5
Issue:    Comma at the end (instead of the correct full stop)

"Recognized values: B<threads>, B<host>, B<port>, B<grace-time>, B<lease-"
"time>, B<udp>, B<tcp>, B<vers3>, B<vers4>, B<vers4.0>, B<vers4.1>, "
"B<vers4.2>, B<rdma>,"
msgstr ""
"Erkannte Werte: B<threads>, B<host>, B<port>, B<grace-time>, B<lease-time>=
, "
"B<udp>, B<tcp>, B<vers3>, B<vers4>, B<vers4.0>, B<vers4.1>, B<vers4.2>, "
"B<rdma>."
--
Man page: nfsd.7
Issue:    back-slash vs. backslash, should be consistent

"Each line of the file contains a path name, a client name, and a number of=
 "
"options in parentheses.  Any space, tab, newline or back-slash character i=
n "
"the path name or client name will be replaced by a backslash followed by t=
he "
"octal ASCII code for that character."
--
Man page: nfsd.7
Issue:    thread currently =E2=86=92 threads currently

"This file represents the number of B<nfsd> thread currently running.  "
"Reading it will show the number of threads.  Writing an ASCII decimal numb=
er "
"will cause the number of threads to be changed (increased or decreased as "
"necessary) to achieve that number."
--
Man page: nfsd.7
Issue:    The first sentence is somewhat logical, but is this really the sp=
eciality of this file?

"This is a somewhat unusual file in that what is read from it depends on wh=
at "
"was just written to it.  It provides a transactional interface where a "
"program can open the file, write a request, and read a response.  If two "
"separate programs open, write, and read at the same time, their requests "
"will not be mixed up."
--
Man page: nfsd.7
Issue:    can be display =E2=86=92 can be displayed

"The directory B</proc/net/rpc> in the B<procfs> filesystem contains a numb=
er "
"of files and directories.  The files contain statistics that can be displa=
y "
"using the I<nfsstat> program.  The directories contain information about "
"various caches that the NFS server maintains to keep track of access "
"permissions that different clients have for different filesystems.  The "
"caches are:"
--
Man page: nfsd.7
Issue 1:  select(2) or poll(2) =E2=86=92 B<select>(2) or B<poll>(2)
Issue 2:  and end-of-file =E2=86=92 an end-of-file

"If the program uses select(2) or poll(2) to discover if it can read from t=
he "
"B<channel> then it will never see and end-of-file but when all requests ha=
ve "
"been answered, it will block until another request appears."
msgstr ""
"Falls das Programm B<select>(2) oder B<poll>(2) verwendet, um "
"herauszufinden, ob es aus dem B<channel> lesen kann, dann wird es niemals "
"ein Dateiende sehen, aber wenn alle Anfragen beantwortet wurden, wird es "
"blockieren, bis eine neue Anfrage erscheint."
--
Man page: nfsmount.conf.5
Issue 1:  =C2=BBVariables are assignmen statements =E2=80=A6 variables=C2=
=AB =E2=80=A6?
Issue 2:  independant =E2=86=92 independent

"The configuration file is made up of multiple section headers followed by "
"variable assignments associated with that section.  A section header is "
"defined by a string enclosed by B<[> and B<]> brackets.  Variable "
"assignments are assignment statements that assign values to particular "
"variables using the B<=3D> operator, as in B<Proto=3DTcp>.  The variables =
that "
"can be assigned are the set of NFS specific mount options listed in "
"B<nfs>(5)  together with the filesystem-independant mount options listed i=
n "
"B<mount>(8)  and three additions: B<Sloppy=3DTrue> has the same effect as =
the "
"B<-s> option to I<mount>, and B<Foreground=3DTrue> and B<Background=3DTrue=
> have "
"the same effect as B<bg> and B<fg>."
--
Man page: nfsmount.conf.5
Issue:    No comma at the end

B<nfs>(5), B<mount>(8),"
--
Man page: nfs.systemd.7
Issue:    changesare make =E2=86=92 changes are made

"When configuration changesare make, it can be hard to know exactly which "
"services need to be restarted to ensure that the configuration takes "
"effect.  The simplest approach, which is often the best, is to restart "
"everything.  To help with this, the B<nfs-utils.service> unit is provided.=
  "
"It declares appropriate dependencies with other unit files so that"
--
Man page: showmount.8
Issue:    (missing) markup of sort -u

"B<showmount> queries the mount daemon on a remote host for information abo=
ut "
"the state of the NFS server on that machine.  With no options B<showmount>=
 "
"lists the set of clients who are mounting from that host.  The output from=
 "
"B<showmount> is designed to appear as though it were processed through "
"``sort -u''."
--
Man page: umount.nfs.8
Issue:    refer =E2=86=92 refer to the

"For further information please refer B<nfs>(5)  and B<umount>(8)  manual "
"pages."
--
Man page: umount.nfs.8
Issue:    comma at the end is superfluous

"B<nfs>(5), B<umount>(8),"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-22767-1671375438-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmOfKk4ACgkQQbqlJmgq
5nC8gxAApMhJJ6y7iP+xnPMpzAEM/w1FkmIU7yn6rNbP9MzKw9csiR7vlDy1OpQ9
TAMmMoCZbRIDzKJN9hV1MnDeSrFPrH0VXfKzyxEA1vD33mZb0HagpRJW+arGqMzT
ubxItVbpquFbXPszrS4OJ5Qh/J+0Mvn7xUBrer3gXQ/KOosW4DpEmHZCYo5qINWY
njNIUaIpP1exPguXkVz+gWPNIaNDwVngi+VWlYYNyq8CxfesZsFHrRNUNNvsyfy3
Hl3boP/pCOJHjLPPbGkErMiw7XHCr/PR3xXOyy7A7+KPQNqwhzeFCaYuTR5OHphZ
GSgDVgOKXZseEy9d5DamSTlmfwGSGxink1rA9Hj5S2gEbxVI5iP4+UqWydxyCS5o
zvw7SJvxXg6qFU1/j/S2GOtzOMOy8Vtppvso/XIfxEuH0cl3KcBXZ5VPPtt3oMbq
OTKESsh1au6oGvmpav0gRC4K7Jr4rPpJw2xRb3j/uZRmMi7/e0loLvhEzcvb2maD
BztQB5aaIJz+3kwqwbfkAiEVuaLTeihGXeIje+9g2uOfNFjWNp+WYqmJ9taQ2Dbw
QjUGXhckTDdBbwDPK5dHxw9Ys462I3IYG4A/N09PG7MF6N6mXt/Z03R5sct6M6Yo
eTxGUvLVky5ckORg1FabzY8Lg7iMiw6h4w8UrWndsueZv4sK1vk=
=IC8/
-----END PGP SIGNATURE-----

--=_luckmann.name-22767-1671375438-0001-2--
