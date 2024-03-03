Return-Path: <linux-nfs+bounces-2143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C0F86F4F4
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 14:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7567CB21B96
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB31F9D9;
	Sun,  3 Mar 2024 13:05:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D205F9DE
	for <linux-nfs@vger.kernel.org>; Sun,  3 Mar 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471118; cv=none; b=UphpcoGMz+MKNO3JBO0+0ddyRiWqEIXZyUgui5aFThvArOmwT4p/i5jm2J6V5oGOYeqgtOAHNoFf9+zatSBNCAKf4ia6pEttYuVC4vep4YyuKH5CA0mxt1hgq0WdFr8fuRTaHxggq946nq2a4rw6tuktCDtbab3CaeZuLRfO4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471118; c=relaxed/simple;
	bh=UCDuK1oGfylu3uTtLHhijQ9s8zQH7Gj18wvdFIV1BfQ=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=pywppxFmdx70WvQBi/NJ2KoCgQWtCBq8vL8PchnDxrk58LB8UCx3N7YiIcB8KC3TmnpV2/OH5oIzqpiQ9buotiAdrNxnQULmmZ4u+nNPtJZBiKoG+MYg31cTVtSNtrTN6EFpyInaBBPTLNVzYFkETCqeizuL+jn+UAzz+BSBU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 00000000000202A1.0000000065E47589.00395B40; Sun, 03 Mar 2024 13:05:13 +0000
Date: Sun, 3 Mar 2024 13:05:13 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: linux-nfs@vger.kernel.org
Subject: Issues in man pages of nfs
Message-ID: <ZeR1ibAcvUX53Rgy@meinfjell.helgefjelltest.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-3758912-1709471113-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-3758912-1709471113-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear NFS maintainer,
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
Issue:    Formmating of device-mapper

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
Issue:    Formatting of syslogd

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
Issue:   Why is the word "option" in bold? Should it be italics?

"The B<sloppy> option is an alternative to specifying B<mount.nfs> -s "
"B<option.>"
--
Man page: nfs.5
Issue:    If is =E2=86=92 If it

"When the client discovers a new filesystem on a NFSv4.1+ server, the "
"B<trunkdiscovery> mount option will cause it to send a GETATTR for the "
"fs_locations attribute.  If is receives a non-zero length reply, it will "
"iterate through the response, and for each server location it will establi=
sh "
"a connection, send an EXCHANGE_ID, and test for session trunking.  If the "
"trunking test succeeds, the connection will be added to the existing set o=
f "
"transports for the server, subject to the limit specified by the "
"B<max_connect> option.  The default is B<notrunkdiscovery>."
--
Man page: nfs.5
Issue:    B<nfsmount.conf(5)> =E2=86=92 B<nfsmount.conf>(5)

"If the mount command is configured to do so, all of the mount options "
"described in the previous section can also be configured in the I</etc/"
"nfsmount.conf> file. See B<nfsmount.conf(5)> for details."
msgstr ""
--
Man page: nfs.conf.5
Issue:    Use full stop at the end of the line instead of comma

"Recognized values: B<threads>, B<host>, B<scope>, B<port>, B<grace-time>, "
"B<lease-time>, B<udp>, B<tcp>, B<vers3>, B<vers4>, B<vers4.0>, B<vers4.1>,=
 "
"B<vers4.2>, B<rdma>,"
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
Issue:    The first sentence is logical, but generic - in every file you re=
ad what you wrote previously?

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
--
Man page: nfsmount.conf.5
Issue 1:  =C2=BBVariables are assignmen statements =E2=80=A6 variables=C2=
=AB =E2=80=A6?
Issue 2: independant =E2=86=92 independent

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
Issue:    Remove comma at the end

"B<nfs>(5), B<mount>(8),"
--
Man page: nfsmount.conf.5
Issue:    over-ride =E2=86=92 override

"Default NFS mount configuration files, variables set in the later file ove=
r-"
"ride those in the earlier file."
--
Man page: nfs.systemd.7
Issue:   changesare make =E2=86=92 changes are made

"When configuration changesare make, it can be hard to know exactly which "
"services need to be restarted to ensure that the configuration takes "
"effect.  The simplest approach, which is often the best, is to restart "
"everything.  To help with this, the B<nfs-utils.service> unit is provided.=
  "
"It declares appropriate dependencies with other unit files so that"
--
Man page: showmount.8
Issue:    formatting of sort -u

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
Issue:    Remove comma at the end

"B<nfs>(5), B<umount>(8),"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-3758912-1709471113-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmXkdYYACgkQQbqlJmgq
5nBg/BAAmBfJQsVrM2Ri/QpBlC955wzX3djfTwl564Hg5qifSG1sYzAbQNkmgHrm
8wHpyAVT6Q/Z3LDXZMhk5qHnHV2uGPUSjFUQlxGSzF9FiSKMVZsjk+L4VWSMMnNh
nptiDztAolOdiZgjOE/co0boZmvWCQRGIdnjWIrqMv7rKW8yk0HgvAhhnKQ84hGj
/MQPzjTSELyy+u6s/hXsDhKlnpSVaFOpy4a4AweqKcu0kfxJ8//1vpU87PFl11AO
eRzR5jhmUCqKF5Nyj4FJo/tfoS6relBu1P7xP8R3//V/yZqkxyOtcVp6wN1le+8c
0bEk2E3WNWYNnbntw0xO+kR9YaatQ3ItPNiBVtntyFEgogNQVNSeLdHLi4tsJ2f6
KG0p6VTyO5FGezQyIAKpgwBP3WKTPGe+SKuLub3DzaWwSJ+q8Zz0Qb6lDp5xnV+X
thwFqd8On7096l05v5KicErCJizQvl9L317U3aMyfGXhWKJ3XR6BfNKZS3enW5sq
wMSEJXRhQj5efRkJUAj52gJ883MABc00b7pCKNwAajUe30GrRBYm9rlGQpUNZORQ
SZ2dLI7u+C3c3/Pe/kVYtdPocKPgYK2jlbum2X8jk9CmCqfSQ7p8BSf+yn2K0yff
GtakWKPkDMsiDYM55QXrahy9gL8hadO2U+gX7YJzY9b02Vu/Ywk=
=mziN
-----END PGP SIGNATURE-----

--=_meinfjell-3758912-1709471113-0001-2--

