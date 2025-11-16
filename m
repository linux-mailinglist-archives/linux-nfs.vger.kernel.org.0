Return-Path: <linux-nfs+bounces-16430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68FC61490
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 13:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EC33B5FD6
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02A2D46B2;
	Sun, 16 Nov 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b="kano2wBv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4B2D3A9E
	for <linux-nfs@vger.kernel.org>; Sun, 16 Nov 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763295293; cv=none; b=p7JqN+QnQUUFCs/ltc67k5vsocU6UtG8p56AWr2gfiCMKMbkd32b367FgIQIUJmekOMteYisZiXydHEKm4bUM3JmHdiv6jAtYjTdnn/Was97j0n4dh8ju/WH3StSfzWGmyKCsZAZii2DtGdc2CPgLWlJ2xupbULt5xx0TzGY4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763295293; c=relaxed/simple;
	bh=Hs3X4HAo7Y51czw92ytTo8h4ASOW0BZVLaLcBgr15ts=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=f3tyMLUxUqmxVPBL4DZ8Ql2AuqnW24Kc/ozz57aSGzEpIBXUKuHjBrSoC1kL7bZxxaisPrO1I4B0968+caB+CczotgtkjeX0HR5/hyIJCmY7zNDC2LMRnWdJ9gumgMNnZ+BHZ/KOk4YbuS2Vul3BDzD5S9lyu/U9IWvpXoPBkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b=kano2wBv; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helgefjell.de;
	s=selector.helgefjell; t=1763294979;
	bh=8CQFJCSX88OU9yEKmvHGaR1nltWixYDF4WIWEOuwuH0=;
	h=Date:From:To:Subject;
	b=kano2wBveIiWme0xXOH6GmhJWdFdim1BblIdmvZ251lHH6JrMjuqMROV/xLmVSCDc
	 sJvdsJ+xpXO+3saDc+4l7Kw4XwFrG7LgxXeWFaQx1WnsJS7NzNMhc0m+HHKmq4uwBo
	 Pn9P1s3g5Zbdjypw7l9HpLYKqkce2+I7uxBsilSevqYji7jGKuVAVo1btq1zUxa0cE
	 A09yjvJ/F45vpwHyiSgacYXgDMvhIrZUXYWZl1wdKTVCwq9PkdLbGvk1JwBJfXnHxP
	 af2ovFJXNZufaMZ0NqAVzmfeJFFnK67FKwSWAQZ5/4psq8+wLV9nK14mdn8K1W5NF4
	 x7Nh8YCjhmwQA==
Original-Subject: Issues in man pages of nfs
Author: Helge Kreutzmann <debian@helgefjell.de>
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 00000000000200EA.000000006919BF03.003C0D73; Sun, 16 Nov 2025 12:09:39 +0000
Date: Sun, 16 Nov 2025 12:09:39 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: linux-nfs@vger.kernel.org
Subject: Issues in man pages of nfs
Message-ID: <aRm_A91ko3DRPtHc@meinfjell.helgefjelltest.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-3935603-1763294979-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-3935603-1763294979-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear nfs maintainer,
the manpage-l10n project[1] maintains a large number of translations of
man pages both from a large variety of sources (including nfs) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
your latest upstream version once in a while, so the error might be
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

I'm now reporting the issues for your project. If future reports
should use another channel, please let me know.

[1] https://manpages-l10n-team.pages.debian.net/manpages-l10n/

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
Issue:    Why is the word "option" in bold? (And not the "-s"?)

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
--
Man page: nfs.conf.5
Issue:    Replace comma at the end by a full stop

"Recognized values: B<threads>, B<host>, B<scope>, B<port>, B<grace-time>, "
"B<lease-time>, B<udp>, B<tcp>, B<vers3>, B<vers4>, B<vers4.0>, B<vers4.1>,=
 "
"B<vers4.2>, B<rdma>,"
--
Man page: nfsd.7
Issue:   back-slash vs. backslash, should be consistent

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
Issue:    The first sentence is logical, but this applies to every file?

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
Man page: nfsd.8
Issue:    B<netconfig(5).> =E2=86=92 B<netconfig>(5) (no full stop in SEE A=
LSO)

"B<nfsd>(7), B<rpc.mountd>(8), B<exports>(5), B<exportfs>(8), B<nfs.conf>(5=
), "
"B<rpc.rquotad>(8), B<nfsstat>(8), B<netconfig(5).>"
--
Man page: nfsmount.conf.5
Issue 1:  "Variables are assignmen statements =E2=80=A6 variables" =E2=80=
=A6?
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
Issue:    over-ride =E2=86=92 override

"Default NFS mount configuration files, variables set in the later file ove=
r-"
"ride those in the earlier file."
--
Man page: nfsmount.conf.5
Issue:    Remove comma at the end (use full stop)

"B<nfs>(5), B<mount>(8),"
--
Man page: nfs.systemd.7
Issue 1:  I<nfs-utils> =E2=86=92 B<nfs-utils>
Issue 2:  I<systemd> =E2=86=92 B<systemd>(8)

"The I<nfs-utils> package provides a suite of I<systemd> unit files and "
"generators which allow the various services to be started and managed.  "
"These unit files and generators ensure that the services are started in th=
e "
"correct order, and the prerequisites are active before dependant services "
"start.  As there are quite a few unit files and generators, it is not "
"immediately obvious how best to achieve certain results.  The following "
"subsections attempt to cover the issues that are most likely to come up."
--
Man page: nfs.systemd.7
Issue 1:  systemd =E2=86=92 B<systemd>(1)
Issue 2:  I<nfs-utils> =E2=86=92 B<nfs-utils>

"systemd unit generators are small executables placed in I</usr/lib/systemd=
/"
"system-generators/> to dynamically extend the unit file hierarchy.  The "
"I<nfs-utils> package provides three:"
--
Man page: nfs.systemd.7
Issue:    /sysroot =E2=86=92 I</sysroot>

"It creates the B<sysroot.mount> unit to mount /sysroot via NFSv4 in the "
"initrd, if it detects one the following options in the kernel command line=
:"
--
Man page: nfs.systemd.7
Issue:    I<nfs-server.service> =E2=86=92 B<nfs-server.service>

"It creates ordering dependencies between I<nfs-server.service> and various=
 "
"filesystem mounts: it should start before any \"nfs\" mountpoints are "
"mounted, in case they are loop-back mounts, and after all exported "
"filesystems are mounted, so there is no risk of exporting the underlying "
"directory."
--
Man page: showmount.8
Issue:    markup of sort -u: B<sort -u>

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
Issue:    Replace final comma by full stop

"B<nfs>(5), B<umount>(8),"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-3935603-1763294979-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmkZvwAACgkQQbqlJmgq
5nAESw/+OxomXAHZ9a/upaabb+KjnIej8lTlZl2A4LCHOSgxl1Y/ITQsFbNGTcye
dkZTPBXCzvqaR3Y115hNgG4QlFPXGJpk1TbNaSxdmIXXmbeVCtogqOcvKvcrhJ97
hG+cUDr0SsGoKJO7/2OGlc4JjMtumLUc5viFU42AW2UeL6PYtYaB8n4669ej7cpS
FfhX+19tI+0Dd7tdVXg790VloqGeLICK9LkmfB9paFLuleOO1KXZrG4yagQFcVTt
X7QRhPtuYVa0OdJDv2cXvHpY+kq+WcDPtSF8mOZljnh9c3OvNU6fk08r1LTueu5w
Uobwo69eLw9mnsn96dSP35cur93jbyG2PWAGgikioOtupprx9Rc6i2iN2T0bYgXS
/AC/resit3XgK0MHw6FZJb2+4Ij8dbnci5vJAsYKXjXobA/4gZ5ke3HFVT5VB7LK
pFK1gAh4neC+60IIH8YJnVvgfC45OsDc8L87WK4Bh79DWEv5qqFoH7joBTrZJ/Lv
9ahhd1UbcF15QA3JnIRR0sg9mWlH7MXMbHUmWB3c8Avwk+5niIihO07Vzz8gdDDa
bQbOjrqMXcfXaFFvnP5hBxAA9S0aMUnWO+ekYH6FaCDATrAza6jU9IRGrjKQLH+C
BZvyCQAtY/oqBPv7lvoWfaAgVYFtq+95TOfKEcRbP9W8uUBYd1g=
=PzcF
-----END PGP SIGNATURE-----

--=_meinfjell-3935603-1763294979-0001-2--

