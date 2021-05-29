Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2114E394BCF
	for <lists+linux-nfs@lfdr.de>; Sat, 29 May 2021 13:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhE2LCi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 May 2021 07:02:38 -0400
Received: from luckmann.name ([213.239.213.133]:51159 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhE2LCi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 May 2021 07:02:38 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 May 2021 07:02:38 EDT
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000BDA009.0000000060B21DBF.00001575; Sat, 29 May 2021 12:55:59 +0200
Date:   Sat, 29 May 2021 12:55:59 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     linux-nfs@vger.kernel.org
Subject: Errors in nfs man pages
Message-ID: <20210529105559.GA5413@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-5493-1622285759-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-5493-1622285759-0001-2
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
Issue: Markup of device-mapper

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
Issue: Markup of syslogd

"Runs B<blkmapd> in the foreground and sends output to stderr (as opposed t=
o "
"syslogd)"
--
Man page: exportfs.8
Issue: missing period at the end of sentence

"B<exportfs> will also recognize the B<state-directory-path> value from bot=
h "
"the B<[mountd]> section and the B<[exportd]> section"
--
Man page: exportfs.8
Issue: B<exports(5)> =E2=86=92 B<exports>(5)

"The I<host:/path> argument specifies a local directory to export, along wi=
th "
"the client or clients who are permitted to access it.  See B<exports(5)> f=
or "
"a description of supported options and access list formats."
--
Man page: nfs.5
Issue: kernel_soruce

"Enable/Disables the cache of (read-only) data pages to the local disk usin=
g "
"the FS-Cache facility. See cachefilesd(8)  and E<lt>kernel_soruceE<gt>/"
"Documentation/filesystems/caching for detail on how to configure the FS-"
"Cache facility.  Default value is nofsc."
--
Man page: nfs.5
Issue: B<nfsmount.conf(5)> =E2=86=92 B<nfsmount.conf>(5)

"If the mount command is configured to do so, all of the mount options "
"described in the previous section can also be configured in the I</etc/"
"nfsmount.conf> file. See B<nfsmount.conf(5)> for details."
--
Man page: nfs.conf.5
Issue: Comma at end of string, should be full stop

"Recognized values: B<threads>, B<host>, B<port>, B<grace-time>, B<lease-"
"time>, B<udp>, B<tcp>, B<vers2>, B<vers3>, B<vers4>, B<vers4.0>, B<vers4.1=
>, "
"B<vers4.2>, B<rdma>,"
--
Man page: nfsd.7
Issue: back-slash vs. backslash, should be consistent

"Each line of the file contains a path name, a client name, and a number of=
 "
"options in parentheses.  Any space, tab, newline or back-slash character i=
n "
"the path name or client name will be replaced by a backslash followed by t=
he "
"octal ASCII code for that character."
--
Man page: nfsd.7
Issue: thread currently =E2=86=92 threads currently

"This file represents the number of B<nfsd> thread currently running.  "
"Reading it will show the number of threads.  Writing an ASCII decimal numb=
er "
"will cause the number of threads to be changed (increased or decreased as "
"necessary) to achieve that number."
--
Man page: nfsd.7
Issue: Check first sentence: This is somehow logical (you would expect to r=
ead what you wrote). Is this really the speciality of this file?

"This is a somewhat unusual file in that what is read from it depends on wh=
at "
"was just written to it.  It provides a transactional interface where a "
"program can open the file, write a request, and read a response.  If two "
"separate programs open, write, and read at the same time, their requests "
"will not be mixed up."
--
Man page: nfsd.7
Issue: can be display =E2=86=92 can be displayed

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
Issue 1: select(2) or poll(2) =E2=86=92 B<select>(2) or B<poll>(2)
Issue 2: and end-of-file =E2=86=92 an end-of-file

"If the program uses select(2) or poll(2) to discover if it can read from t=
he "
"B<channel> then it will never see and end-of-file but when all requests ha=
ve "
"been answered, it will block until another request appears."
--
Man page: nfsmount.conf.5
Issue 1: =C2=BBVariables are assignment statements =E2=80=A6 variables=C2=
=AB =E2=80=A6?
Issue 2: and end-of-file =E2=86=92 an end-of-file

"The configuration file is made up of multiple section headers followed by "
"variable assignments associated with that section.  A section header is "
"defined by a string enclosed by B<[> and B<]> brackets.  Variable "
"assignments are assignment statements that assign values to particular "
"variables using the B<=3D> operator, as in B<Proto=3DTcp>.  The variables =
that "
"can be assigned are the set of NFS specific mount options listed in "
"B<nfs>(5)  together with the filesystem-independant mount options listed i=
n "
--
Man page: nfsd.7
Issue: Superfluous comma at the end

"B<nfs>(5), B<mount>(8),"
--
Man page: nfs.systemd.7
Issue: changesare make =E2=86=92 changes are made

"When configuration changesare make, it can be hard to know exactly which "
"services need to be restarted to ensure that the configuration takes "
"effect.  The simplest approach, which is often the best, is to restart "
"everything.  To help with this, the B<nfs-utils.service> unit is provided.=
  "
"It declares appropriate dependencies with other unit files so that"
--
Man page: showmount.8
Issue: (missing) markup of sort -u

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
Issue: refer =E2=86=92 refer to the

"For further information please refer B<nfs>(5)  and B<umount>(8)  manual "
"pages."
--
Man page: umount.nfs.8
Issue: Superfluous comma at the end

"B<nfs>(5), B<umount>(8),"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-5493-1622285759-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmCyHboACgkQQbqlJmgq
5nCCDQ//Y0D6xy4Y4k5I30HUG2BNWf6sUoIbOje4/+dGGHJHODZt1Lob2SOQxB0W
H+e3RDHESdM90IRaW5jMkqKjgBiU+JdlqKAQECWDL/RA6yHFqqEVTrLD9zwgLkEU
a0Z+RZmKWI4XpOnxl+O14j9Twm8c2GpAjB7Q0T9qJZiJpHBuyKenHlY5AYEHVQgR
x6a+q2YPZqmsnRN2MRI2UpnfWi34edgLexWCqQQqKZ46wJY7huVXmkkCQtzN3StI
MR/Yw2XpLs7cIYk5MWJ/o+h4+Q+VkqHqpJwy4sxeMRBesnu+JJUdl8WlmaXNdI6q
rgmpC2wV8+kxgAuMbZ1k0vYqCgtqpEO6EEetfH71z3m/Puh4BCzQk+k/WVsnhEkq
As9MtBqqNLvdzBp+J630ldiZMG8sGjPYC3Ogfl0DD35dCMbQ6k4lI2hhPxzFX16k
LFk1VlUFBewImmKOUq2+AOTf38nrU9/VuVczYGMAq4tdqStBzRvbMpnvFds/T6QZ
7K7rY3PyjW/IdKoVTB4TgVBPXNbuCvCWIn5+mwMkpmwieT5CyXSUDGqDJTo8gZhC
KVCCBfRYbpSKhLizaODPJDxR9MKy0EDG7wITz12twrTqNCL7G8X6yOqbaIdexNQB
USPCc+HwZqP61uta9jUjUDa93Oa/wHgzJv87y75FH6O24sZKlPA=
=ftGz
-----END PGP SIGNATURE-----

--=_luckmann.name-5493-1622285759-0001-2--
