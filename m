Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24342224CC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 16:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgGPOC6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 10:02:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39202 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbgGPOC6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 10:02:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GDv1lV163329;
        Thu, 16 Jul 2020 14:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=xAZ9fFyDIu2T5LmJgrmylyu9xnLLjhY/yu3pN0m1Fkk=;
 b=kVefNiqdCx+afRdqGzzAb30eirJ9hATE1lE/wWzP9gIHoCn4ktx53wWwKnj5ngnYWyPl
 3b3GC6ayTUgEr9yZWEOKL0BRP/0+ixFfPBN0AnUkL7V/VblEF1iDEsKnns8uFZgFKtwf
 CDKnpvQS9/s/+MBy9v+9hFCn7e2yiqhHyPgB//ekejVfTRYhknCb2gCsVOX0XIZxqr8G
 7wrSYneyUAUUYqqWnqjoq7SyDAE32f0DaAHe04QuCsu9TSAwCs6YxPz4bjKlPGpPIaLX
 OLbKT4aoiG7RRkH1wx6+m0btjQkun1HA0pbO47rYdhVJwI6SzwzdNDVzeiPO3tB79+qT xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3275cmhhx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 14:02:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GDvhGD085105;
        Thu, 16 Jul 2020 14:02:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 327qbbew5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 14:02:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06GE2nOQ016841;
        Thu, 16 Jul 2020 14:02:49 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jul 2020 07:02:49 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 4/4] nfs-utils: Update nfs4_unique_id module parameter
 from the nfs.conf value
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ff4f8d30e849190eeb2e0fee1ef501ee461a531f.camel@redhat.com>
Date:   Thu, 16 Jul 2020 10:02:48 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F25A094C-CA96-45D3-8422-C2F77ECF9C78@oracle.com>
References: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
 <ff4f8d30e849190eeb2e0fee1ef501ee461a531f.camel@redhat.com>
To:     Alice Mitchell <ajmitchell@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=9 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160108
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Alice-

I agree that selecting a unique nfs4_client_id string is a problem.

However, I thought that Trond is working on a udev-based mechanism
for automatically choosing one that uniquifies containers as well
as stand-alone clients.

I'd prefer if we stuck with one mechanism for doing this rather than
having both.

Is there rationale for having this in nfs.conf instead of being
completely opaque to the administrator? I don't see a compelling
need for an administrator to adjust this if it is truly a random
string of bytes. Do you know of one?


> On Jul 16, 2020, at 9:56 AM, Alice Mitchell <ajmitchell@redhat.com> =
wrote:
>=20
> This reintroduces the nfs-config.service in order to ensure
> that values are taken from nfs.conf and fed to the kernel
> module if it is loaded and modprobe.d config incase it is not
>=20
> Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
> ---
> nfs.conf                      |  1 +
> systemd/Makefile.am           |  3 +++
> systemd/README                |  5 +++++
> systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
> systemd/nfs-config.service.in | 17 +++++++++++++++++
> systemd/nfs.conf.man          | 12 +++++++++++-
> 6 files changed, 65 insertions(+), 1 deletion(-)
> create mode 100755 systemd/nfs-conf-export.sh
> create mode 100644 systemd/nfs-config.service.in
>=20
> diff --git a/nfs.conf b/nfs.conf
> index 186a5b19..8bb41227 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -4,6 +4,7 @@
> #
> [general]
> # pipefs-directory=3D/var/lib/nfs/rpc_pipefs
> +# nfs4_unique_id =3D ${machine-id}
> #
> [exports]
> # rootdir=3D/export
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index 75cdd9f5..51acdc3f 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -9,6 +9,7 @@ unit_files =3D  \
>     nfs-mountd.service \
>     nfs-server.service \
>     nfs-utils.service \
> +    nfs-config.service \
>     rpc-statd-notify.service \
>     rpc-statd.service \
>     \
> @@ -69,4 +70,6 @@ genexec_PROGRAMS =3D nfs-server-generator =
rpc-pipefs-generator
> install-data-hook: $(unit_files)
> 	mkdir -p $(DESTDIR)/$(unitdir)
> 	cp $(unit_files) $(DESTDIR)/$(unitdir)
> +	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
> +	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
> endif
> diff --git a/systemd/README b/systemd/README
> index da23d6f6..56108b10 100644
> --- a/systemd/README
> +++ b/systemd/README
> @@ -28,6 +28,11 @@ by a suitable 'preset' setting:
>     If enabled, then blkmapd will be run when nfs-client.target is
>     started.
>=20
> + nfs-config.service
> +    Invoked by nfs-client.target to export values from nfs.conf to
> +    any kernel modules that require it, such as setting =
nfs4_unique_id
> +    for the nfs client modules
> +
> Another special unit is "nfs-utils.service".  This doesn't really do
> anything, but exists so that other units may declare themselves as
> "PartOf" nfs-utils.service.
> diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-export.sh
> new file mode 100755
> index 00000000..486e8df9
> --- /dev/null
> +++ b/systemd/nfs-conf-export.sh
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +#
> +# This script pulls values out of /etc/nfs.conf and configures
> +# the appropriate kernel modules which cannot read it directly
> +
> +NFSMOD=3D/sys/module/nfs/parameters/nfs4_unique_id
> +NFSPROBE=3D/etc/modprobe.d/nfs.conf
> +
> +# Now read the values from nfs.conf
> +MACHINEID=3D`nfsconf --get general nfs4_unique_id`
> +if [ $? -ne 0 ] || [ "$MACHINEID" =3D=3D "" ]
> +then
> +# No config vaue found, assume blank
> +MACHINEID=3D""
> +fi
> +
> +# Kernel module is already loaded, update the live one
> +if [ -e $NFSMOD ]; then
> +echo -n "$MACHINEID" >> $NFSMOD
> +fi
> +
> +# Rewrite the modprobe file for next reboot
> +echo "# This file is overwritten by systemd nfs-config.service" > =
$NFSPROBE
> +echo "# with values taken from /etc/nfs.conf" >> $NFSPROBE
> +echo "# Do not hand modify" >> $NFSPROBE
> +echo "options nfs nfs4_unique_id=3D\"$MACHINEID\"" >> $NFSPROBE
> +
> +echo "Set to: $MACHINEID"
> diff --git a/systemd/nfs-config.service.in =
b/systemd/nfs-config.service.in
> new file mode 100644
> index 00000000..c5ef1024
> --- /dev/null
> +++ b/systemd/nfs-config.service.in
> @@ -0,0 +1,17 @@
> +[Unit]
> +Description=3DPreprocess NFS configuration
> +PartOf=3Dnfs-client.target
> +After=3Dnfs-client.target
> +DefaultDependencies=3Dno
> +
> +[Service]
> +Type=3Doneshot
> +# This service needs to run any time any nfs service
> +# is started, so changes to local config files get
> +# incorporated.  Having "RemainAfterExit=3Dno" (the default)
> +# ensures this happens.
> +RemainAfterExit=3Dno
> +ExecStart=3D@_libexecdir@/nfs-utils/nfs-conf-export.sh
> +
> +[Install]
> +WantedBy=3Dnfs-client.target
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index 28dbaa99..fb9d2dab 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -101,8 +101,11 @@ When a list is given, the members should be =
comma-separated.
> .TP
> .B general
> Recognized values:
> -.BR pipefs-directory .
> +.BR pipefs-directory ,
> +.BR nfs4_unique_id .
>=20
> +For=20
> +.BR pipefs-directory
> See
> .BR blkmapd (8),
> .BR rpc.idmapd (8),
> @@ -110,6 +113,13 @@ and
> .BR rpc.gssd (8)
> for details.
>=20
> +The
> +.BR nfs4_unique_id
> +value is used by the NFS4 client when identifying itself to servers =
and
> +can be used to ensure that this value is unique when the local system =
name
> +perhaps is not. For full details please refer to the kernel =
Documentation
> +.I filesystems/nfs/nfs.txt
> +
> .TP
> .B exports
> Recognized values:
> --=20
> 2.18.1
>=20
>=20

--
Chuck Lever



