Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB60225E7B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 14:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGTMZR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 08:25:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35920 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgGTMZR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 08:25:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCGRur078567;
        Mon, 20 Jul 2020 12:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Sh68MWbF2KzJIx+piFa3+Osbri4LBroPSa19TLpywp0=;
 b=XyLBbP71J9Pgm9zHdOYnXl8ImZojtDQGc6kFoHYY8elhFPitl5Oo9KIMH59ThwGCma+s
 BH1iEhoCQzQ9boQJmbYq1fduXc7lfwUn4aSdB7L7796FPdOSShqoCHfChvwSDFLWaLjU
 yycU3ZLOtSp1Ei57Z7yQ39HkcQRd7svGGH3seESkjJLmaKtDrBzRoarFdzCTUR+Qaiu6
 HDR3L5olKfBjBU1dYPe7HmdRCH5LdcOeNARqQgGRsq2h5RGkMBbpOkTf+abkRQ7j87r9
 pTkEeEreitBaTUrizd5ITSCutbJPDgmJmkpaMxWwofToV+SZyp2zwdm4g50nVRXlhV4q Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32brgr6m3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 12:25:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCDFw4042827;
        Mon, 20 Jul 2020 12:25:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32da2cvf7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 12:25:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KCP6Uh014736;
        Mon, 20 Jul 2020 12:25:07 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 12:25:06 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 4/4] nfs-utils: Update nfs4_unique_id module parameter
 from the nfs.conf value
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <4dc8c372324d551456a47e60d73d926d96fc0d24.camel@redhat.com>
Date:   Mon, 20 Jul 2020 08:25:05 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <8A012232-2068-4619-8056-4F1B4323DEAF@oracle.com>
References: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
 <ff4f8d30e849190eeb2e0fee1ef501ee461a531f.camel@redhat.com>
 <F25A094C-CA96-45D3-8422-C2F77ECF9C78@oracle.com>
 <4dc8c372324d551456a47e60d73d926d96fc0d24.camel@redhat.com>
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=9 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=9 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200085
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Alice-

> On Jul 19, 2020, at 3:57 PM, Alice Mitchell <ajmitchell@redhat.com> wrote:
> 
> Hi Chuck,
> I must have missed the discussion on Trond's work sorry, and I agree
> that having it fixed in a way that is both automatic and transparent to
> the user is far preferable to the solution I have posted. Do we have
> any timeline on this yet ?

No timeline, unless Trond has something ready now.


> My proposed solution would therefore be a stop-gap if required, as it
> does not force any specific solution upon the system and merely adds a
> few small features in order to assist the administrator if they choose
> to make use of the existing kernel module option, in a way which would
> preserve the idea of centralised configuration.

My concern is that you are proposing a mechanism that is visible to
administrators that we would need to alter again in the near- to mid-
term. For a stop-gap, a mechanism not visible to administrators would
be easier for us to modify/improve at will.

It looks like this can be containerized by having a unique nfs.conf
for each container. Is that correct?


> As an aside I was also going to propose the use of this same mechanism
> to address the issue of the lockd options for port numbers, which as it
> currently stands are manually set in both modprobe.d and in nfs.conf,
> which as i understand it both must match for successful operation.  A
> small addition to the scripts I have posted could see the modules.d
> options automatically generated from the nfs.conf options, thus
> reducing the scope for mistakes if the administrator chooses to alter
> those values and further solidifying the idea of gathering all the
> configuration in a single location.

Using module parameters means the initramfs needs to be rebuilt after
a parameter has changed, at least on my RHEL-based systems. 

Also, these parameters are not containerized -- the setting would take
effect for all network namespaces.


> Your thoughts as always are appreciated.
> 
> -Alice 
> 
> 
> On Thu, 2020-07-16 at 10:02 -0400, Chuck Lever wrote:
>> Hi Alice-
>> 
>> I agree that selecting a unique nfs4_client_id string is a problem.
>> 
>> However, I thought that Trond is working on a udev-based mechanism
>> for automatically choosing one that uniquifies containers as well
>> as stand-alone clients.
>> 
>> I'd prefer if we stuck with one mechanism for doing this rather than
>> having both.
>> 
>> Is there rationale for having this in nfs.conf instead of being
>> completely opaque to the administrator? I don't see a compelling
>> need for an administrator to adjust this if it is truly a random
>> string of bytes. Do you know of one?
>> 
>> 
>>> On Jul 16, 2020, at 9:56 AM, Alice Mitchell <ajmitchell@redhat.com>
>>> wrote:
>>> 
>>> This reintroduces the nfs-config.service in order to ensure
>>> that values are taken from nfs.conf and fed to the kernel
>>> module if it is loaded and modprobe.d config incase it is not
>>> 
>>> Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
>>> ---
>>> nfs.conf                      |  1 +
>>> systemd/Makefile.am           |  3 +++
>>> systemd/README                |  5 +++++
>>> systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
>>> systemd/nfs-config.service.in | 17 +++++++++++++++++
>>> systemd/nfs.conf.man          | 12 +++++++++++-
>>> 6 files changed, 65 insertions(+), 1 deletion(-)
>>> create mode 100755 systemd/nfs-conf-export.sh
>>> create mode 100644 systemd/nfs-config.service.in
>>> 
>>> diff --git a/nfs.conf b/nfs.conf
>>> index 186a5b19..8bb41227 100644
>>> --- a/nfs.conf
>>> +++ b/nfs.conf
>>> @@ -4,6 +4,7 @@
>>> #
>>> [general]
>>> # pipefs-directory=/var/lib/nfs/rpc_pipefs
>>> +# nfs4_unique_id = ${machine-id}
>>> #
>>> [exports]
>>> # rootdir=/export
>>> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
>>> index 75cdd9f5..51acdc3f 100644
>>> --- a/systemd/Makefile.am
>>> +++ b/systemd/Makefile.am
>>> @@ -9,6 +9,7 @@ unit_files =  \
>>>    nfs-mountd.service \
>>>    nfs-server.service \
>>>    nfs-utils.service \
>>> +    nfs-config.service \
>>>    rpc-statd-notify.service \
>>>    rpc-statd.service \
>>>    \
>>> @@ -69,4 +70,6 @@ genexec_PROGRAMS = nfs-server-generator rpc-
>>> pipefs-generator
>>> install-data-hook: $(unit_files)
>>> 	mkdir -p $(DESTDIR)/$(unitdir)
>>> 	cp $(unit_files) $(DESTDIR)/$(unitdir)
>>> +	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
>>> +	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
>>> endif
>>> diff --git a/systemd/README b/systemd/README
>>> index da23d6f6..56108b10 100644
>>> --- a/systemd/README
>>> +++ b/systemd/README
>>> @@ -28,6 +28,11 @@ by a suitable 'preset' setting:
>>>    If enabled, then blkmapd will be run when nfs-client.target is
>>>    started.
>>> 
>>> + nfs-config.service
>>> +    Invoked by nfs-client.target to export values from nfs.conf to
>>> +    any kernel modules that require it, such as setting
>>> nfs4_unique_id
>>> +    for the nfs client modules
>>> +
>>> Another special unit is "nfs-utils.service".  This doesn't really
>>> do
>>> anything, but exists so that other units may declare themselves as
>>> "PartOf" nfs-utils.service.
>>> diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-
>>> export.sh
>>> new file mode 100755
>>> index 00000000..486e8df9
>>> --- /dev/null
>>> +++ b/systemd/nfs-conf-export.sh
>>> @@ -0,0 +1,28 @@
>>> +#!/bin/bash
>>> +#
>>> +# This script pulls values out of /etc/nfs.conf and configures
>>> +# the appropriate kernel modules which cannot read it directly
>>> +
>>> +NFSMOD=/sys/module/nfs/parameters/nfs4_unique_id
>>> +NFSPROBE=/etc/modprobe.d/nfs.conf
>>> +
>>> +# Now read the values from nfs.conf
>>> +MACHINEID=`nfsconf --get general nfs4_unique_id`
>>> +if [ $? -ne 0 ] || [ "$MACHINEID" == "" ]
>>> +then
>>> +# No config vaue found, assume blank
>>> +MACHINEID=""
>>> +fi
>>> +
>>> +# Kernel module is already loaded, update the live one
>>> +if [ -e $NFSMOD ]; then
>>> +echo -n "$MACHINEID" >> $NFSMOD
>>> +fi
>>> +
>>> +# Rewrite the modprobe file for next reboot
>>> +echo "# This file is overwritten by systemd nfs-config.service" >
>>> $NFSPROBE
>>> +echo "# with values taken from /etc/nfs.conf" >> $NFSPROBE
>>> +echo "# Do not hand modify" >> $NFSPROBE
>>> +echo "options nfs nfs4_unique_id=\"$MACHINEID\"" >> $NFSPROBE
>>> +
>>> +echo "Set to: $MACHINEID"
>>> diff --git a/systemd/nfs-config.service.in b/systemd/nfs-
>>> config.service.in
>>> new file mode 100644
>>> index 00000000..c5ef1024
>>> --- /dev/null
>>> +++ b/systemd/nfs-config.service.in
>>> @@ -0,0 +1,17 @@
>>> +[Unit]
>>> +Description=Preprocess NFS configuration
>>> +PartOf=nfs-client.target
>>> +After=nfs-client.target
>>> +DefaultDependencies=no
>>> +
>>> +[Service]
>>> +Type=oneshot
>>> +# This service needs to run any time any nfs service
>>> +# is started, so changes to local config files get
>>> +# incorporated.  Having "RemainAfterExit=no" (the default)
>>> +# ensures this happens.
>>> +RemainAfterExit=no
>>> +ExecStart=@_libexecdir@/nfs-utils/nfs-conf-export.sh
>>> +
>>> +[Install]
>>> +WantedBy=nfs-client.target
>>> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
>>> index 28dbaa99..fb9d2dab 100644
>>> --- a/systemd/nfs.conf.man
>>> +++ b/systemd/nfs.conf.man
>>> @@ -101,8 +101,11 @@ When a list is given, the members should be
>>> comma-separated.
>>> .TP
>>> .B general
>>> Recognized values:
>>> -.BR pipefs-directory .
>>> +.BR pipefs-directory ,
>>> +.BR nfs4_unique_id .
>>> 
>>> +For 
>>> +.BR pipefs-directory
>>> See
>>> .BR blkmapd (8),
>>> .BR rpc.idmapd (8),
>>> @@ -110,6 +113,13 @@ and
>>> .BR rpc.gssd (8)
>>> for details.
>>> 
>>> +The
>>> +.BR nfs4_unique_id
>>> +value is used by the NFS4 client when identifying itself to
>>> servers and
>>> +can be used to ensure that this value is unique when the local
>>> system name
>>> +perhaps is not. For full details please refer to the kernel
>>> Documentation
>>> +.I filesystems/nfs/nfs.txt
>>> +
>>> .TP
>>> .B exports
>>> Recognized values:
>>> -- 
>>> 2.18.1
>>> 
>>> 
>> 
>> --
>> Chuck Lever
>> 
>> 
>> 
> 

--
Chuck Lever



