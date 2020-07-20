Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198FE226E30
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 20:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgGTSXf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 14:23:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTSXd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 14:23:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KIHHxV003180;
        Mon, 20 Jul 2020 18:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ARdl/RrLKgjfbYC+RxjwdTCfo5M9PsLFD919N6vfGTk=;
 b=gAYOrFFjAK3yixl806SXlF0Li2qIRM2DN2bXTMEK9rzLEKnPLrxryBj7NZUnOsksFIv7
 fju+xmTtHjJFQzN3g5KsRzLShdcp7Q99AWyk4kesITKAwn4+xwAn+FvHQ63TTXXvEyjG
 E+ep1kg4VWXkwvDgd+RImv1ZAVpXyIY6gKBUF1FocsmFY3vWRT2zqTGhojpo5xuibemQ
 yDQalYMijuWlnotc/Y1WRiQPMFyzDEwraVObKhh0t7GTtcV4z7A1VIUugOBzxPD71ATe
 2v+FToih3M/9ruOdj4UJOofh5OXmWQ1OGFqhYA8TeadrukTp5nV48ALZCX3bfh8HGF63 Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32bs1m8kjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 18:23:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KIJRPG047077;
        Mon, 20 Jul 2020 18:23:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32d8m0gqcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 18:23:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06KINSwk019046;
        Mon, 20 Jul 2020 18:23:28 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 18:23:27 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 4/4] nfs-utils: Update nfs4_unique_id module parameter
 from the nfs.conf value
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a6756b37-fe93-bf0c-715c-82a62407ead9@RedHat.com>
Date:   Mon, 20 Jul 2020 14:23:26 -0400
Cc:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1D15C75-D811-4214-8818-FBB99A7E48E6@oracle.com>
References: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
 <ff4f8d30e849190eeb2e0fee1ef501ee461a531f.camel@redhat.com>
 <F25A094C-CA96-45D3-8422-C2F77ECF9C78@oracle.com>
 <4dc8c372324d551456a47e60d73d926d96fc0d24.camel@redhat.com>
 <a6756b37-fe93-bf0c-715c-82a62407ead9@RedHat.com>
To:     Steve Dickson <SteveD@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200124
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 20, 2020, at 1:54 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>=20
> Hello,
>=20
> On 7/19/20 3:57 PM, Alice Mitchell wrote:
>> Hi Chuck,
>> I must have missed the discussion on Trond's work sorry, and I agree
>> that having it fixed in a way that is both automatic and transparent =
to
>> the user is far preferable to the solution I have posted. Do we have
>> any timeline on this yet ?
> I too did missed  the discussion... Chuck or Trond can you give us =
more=20
> context on how this is going to work automatically and transparent?
> Is there a thread you can point us to?

=
https://lore.kernel.org/linux-nfs/20190611180832.119488-1-trond.myklebust@=
hammerspace.com/


>> My proposed solution would therefore be a stop-gap if required, as it
>> does not force any specific solution upon the system and merely adds =
a
>> few small features in order to assist the administrator if they =
choose
>> to make use of the existing kernel module option, in a way which =
would
>> preserve the idea of centralised configuration.
> I think I agree with Chuck... Once we add something to a=20
> configuration file it is awful hard to back it out...=20
>=20
> I'm not against setting it in nfs.conf... But if it can be
> set easier from the kernel... so be it!
>=20
>>=20
>> As an aside I was also going to propose the use of this same =
mechanism
>> to address the issue of the lockd options for port numbers, which as =
it
>> currently stands are manually set in both modprobe.d and in nfs.conf,
>> which as i understand it both must match for successful operation.  A
>> small addition to the scripts I have posted could see the modules.d
>> options automatically generated from the nfs.conf options, thus
>> reducing the scope for mistakes if the administrator chooses to alter
>> those values and further solidifying the idea of gathering all the
>> configuration in a single location.
> I kinda like the idea to be able to set lockd ports from
> nfs.conf. We've done that in the past which was lost
> when we moved systemd.=20
>=20
> steved.
>=20
>>=20
>> Your thoughts as always are appreciated.
>>=20
>> -Alice=20
>>=20
>>=20
>> On Thu, 2020-07-16 at 10:02 -0400, Chuck Lever wrote:
>>> Hi Alice-
>>>=20
>>> I agree that selecting a unique nfs4_client_id string is a problem.
>>>=20
>>> However, I thought that Trond is working on a udev-based mechanism
>>> for automatically choosing one that uniquifies containers as well
>>> as stand-alone clients.
>>>=20
>>> I'd prefer if we stuck with one mechanism for doing this rather than
>>> having both.
>>>=20
>>> Is there rationale for having this in nfs.conf instead of being
>>> completely opaque to the administrator? I don't see a compelling
>>> need for an administrator to adjust this if it is truly a random
>>> string of bytes. Do you know of one?
>>>=20
>>>=20
>>>> On Jul 16, 2020, at 9:56 AM, Alice Mitchell <ajmitchell@redhat.com>
>>>> wrote:
>>>>=20
>>>> This reintroduces the nfs-config.service in order to ensure
>>>> that values are taken from nfs.conf and fed to the kernel
>>>> module if it is loaded and modprobe.d config incase it is not
>>>>=20
>>>> Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
>>>> ---
>>>> nfs.conf                      |  1 +
>>>> systemd/Makefile.am           |  3 +++
>>>> systemd/README                |  5 +++++
>>>> systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
>>>> systemd/nfs-config.service.in | 17 +++++++++++++++++
>>>> systemd/nfs.conf.man          | 12 +++++++++++-
>>>> 6 files changed, 65 insertions(+), 1 deletion(-)
>>>> create mode 100755 systemd/nfs-conf-export.sh
>>>> create mode 100644 systemd/nfs-config.service.in
>>>>=20
>>>> diff --git a/nfs.conf b/nfs.conf
>>>> index 186a5b19..8bb41227 100644
>>>> --- a/nfs.conf
>>>> +++ b/nfs.conf
>>>> @@ -4,6 +4,7 @@
>>>> #
>>>> [general]
>>>> # pipefs-directory=3D/var/lib/nfs/rpc_pipefs
>>>> +# nfs4_unique_id =3D ${machine-id}
>>>> #
>>>> [exports]
>>>> # rootdir=3D/export
>>>> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
>>>> index 75cdd9f5..51acdc3f 100644
>>>> --- a/systemd/Makefile.am
>>>> +++ b/systemd/Makefile.am
>>>> @@ -9,6 +9,7 @@ unit_files =3D  \
>>>>    nfs-mountd.service \
>>>>    nfs-server.service \
>>>>    nfs-utils.service \
>>>> +    nfs-config.service \
>>>>    rpc-statd-notify.service \
>>>>    rpc-statd.service \
>>>>    \
>>>> @@ -69,4 +70,6 @@ genexec_PROGRAMS =3D nfs-server-generator rpc-
>>>> pipefs-generator
>>>> install-data-hook: $(unit_files)
>>>> 	mkdir -p $(DESTDIR)/$(unitdir)
>>>> 	cp $(unit_files) $(DESTDIR)/$(unitdir)
>>>> +	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
>>>> +	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
>>>> endif
>>>> diff --git a/systemd/README b/systemd/README
>>>> index da23d6f6..56108b10 100644
>>>> --- a/systemd/README
>>>> +++ b/systemd/README
>>>> @@ -28,6 +28,11 @@ by a suitable 'preset' setting:
>>>>    If enabled, then blkmapd will be run when nfs-client.target is
>>>>    started.
>>>>=20
>>>> + nfs-config.service
>>>> +    Invoked by nfs-client.target to export values from nfs.conf to
>>>> +    any kernel modules that require it, such as setting
>>>> nfs4_unique_id
>>>> +    for the nfs client modules
>>>> +
>>>> Another special unit is "nfs-utils.service".  This doesn't really
>>>> do
>>>> anything, but exists so that other units may declare themselves as
>>>> "PartOf" nfs-utils.service.
>>>> diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-
>>>> export.sh
>>>> new file mode 100755
>>>> index 00000000..486e8df9
>>>> --- /dev/null
>>>> +++ b/systemd/nfs-conf-export.sh
>>>> @@ -0,0 +1,28 @@
>>>> +#!/bin/bash
>>>> +#
>>>> +# This script pulls values out of /etc/nfs.conf and configures
>>>> +# the appropriate kernel modules which cannot read it directly
>>>> +
>>>> +NFSMOD=3D/sys/module/nfs/parameters/nfs4_unique_id
>>>> +NFSPROBE=3D/etc/modprobe.d/nfs.conf
>>>> +
>>>> +# Now read the values from nfs.conf
>>>> +MACHINEID=3D`nfsconf --get general nfs4_unique_id`
>>>> +if [ $? -ne 0 ] || [ "$MACHINEID" =3D=3D "" ]
>>>> +then
>>>> +# No config vaue found, assume blank
>>>> +MACHINEID=3D""
>>>> +fi
>>>> +
>>>> +# Kernel module is already loaded, update the live one
>>>> +if [ -e $NFSMOD ]; then
>>>> +echo -n "$MACHINEID" >> $NFSMOD
>>>> +fi
>>>> +
>>>> +# Rewrite the modprobe file for next reboot
>>>> +echo "# This file is overwritten by systemd nfs-config.service" >
>>>> $NFSPROBE
>>>> +echo "# with values taken from /etc/nfs.conf" >> $NFSPROBE
>>>> +echo "# Do not hand modify" >> $NFSPROBE
>>>> +echo "options nfs nfs4_unique_id=3D\"$MACHINEID\"" >> $NFSPROBE
>>>> +
>>>> +echo "Set to: $MACHINEID"
>>>> diff --git a/systemd/nfs-config.service.in b/systemd/nfs-
>>>> config.service.in
>>>> new file mode 100644
>>>> index 00000000..c5ef1024
>>>> --- /dev/null
>>>> +++ b/systemd/nfs-config.service.in
>>>> @@ -0,0 +1,17 @@
>>>> +[Unit]
>>>> +Description=3DPreprocess NFS configuration
>>>> +PartOf=3Dnfs-client.target
>>>> +After=3Dnfs-client.target
>>>> +DefaultDependencies=3Dno
>>>> +
>>>> +[Service]
>>>> +Type=3Doneshot
>>>> +# This service needs to run any time any nfs service
>>>> +# is started, so changes to local config files get
>>>> +# incorporated.  Having "RemainAfterExit=3Dno" (the default)
>>>> +# ensures this happens.
>>>> +RemainAfterExit=3Dno
>>>> +ExecStart=3D@_libexecdir@/nfs-utils/nfs-conf-export.sh
>>>> +
>>>> +[Install]
>>>> +WantedBy=3Dnfs-client.target
>>>> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
>>>> index 28dbaa99..fb9d2dab 100644
>>>> --- a/systemd/nfs.conf.man
>>>> +++ b/systemd/nfs.conf.man
>>>> @@ -101,8 +101,11 @@ When a list is given, the members should be
>>>> comma-separated.
>>>> .TP
>>>> .B general
>>>> Recognized values:
>>>> -.BR pipefs-directory .
>>>> +.BR pipefs-directory ,
>>>> +.BR nfs4_unique_id .
>>>>=20
>>>> +For=20
>>>> +.BR pipefs-directory
>>>> See
>>>> .BR blkmapd (8),
>>>> .BR rpc.idmapd (8),
>>>> @@ -110,6 +113,13 @@ and
>>>> .BR rpc.gssd (8)
>>>> for details.
>>>>=20
>>>> +The
>>>> +.BR nfs4_unique_id
>>>> +value is used by the NFS4 client when identifying itself to
>>>> servers and
>>>> +can be used to ensure that this value is unique when the local
>>>> system name
>>>> +perhaps is not. For full details please refer to the kernel
>>>> Documentation
>>>> +.I filesystems/nfs/nfs.txt
>>>> +
>>>> .TP
>>>> .B exports
>>>> Recognized values:
>>>> --=20
>>>> 2.18.1
>>>>=20
>>>>=20
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>>>=20
>>>=20
>>=20
>=20

--
Chuck Lever



