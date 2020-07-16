Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2C2227D9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 17:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgGPPw6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 11:52:58 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:32303 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPPw6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 11:52:58 -0400
IronPort-SDR: od5Qh6t4VB0EWXQFczDOul1pys9HOM2LNEPte747ZmKGjr4P3BNTqt6ntC04mseL8OCfTBzsW4
 o6nITysylSxat1/hBqkwf5WnNUvtGYHv8V9toR0Uod5KRiX0ToLYsVqkmGTfCnaYxQBTjsKc5D
 QUweTuOpmbSyvyG3hfYE+/Mk6A3X14XVg8TBazehgX0PP/iTZZgqVY30ND/RqWJHqFOwPhdhVf
 YahCpeZ/WKszFc2H33/4GaMOSKrHRe+hcORfxy5dEVznKzmucSUcuLIaGoMay4DXuLdqoWaihh
 bkE=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 220862180
IronPort-PHdr: =?us-ascii?q?9a23=3AwmWXvBS1kzlWfWlmOm0ppAbtGdpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBtmJ9f1JkazVvrrmVGhG5oyO4zgOc51JAh?=
 =?us-ascii?q?kCj8he3wktG9WMBkCzKvn2Jzc7E8JPWB4AnTm7PEFZFdy4awjUpXu/viAdFw?=
 =?us-ascii?q?+5NgdvIOnxXInIgJf/2+W74ZaGZQJOiXK0aq9zKxPjqwLXu6x0yYtvI6o80F?=
 =?us-ascii?q?3HuHxNLuFf2WMuOE6ejx/noMq84c1u?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GxAAAgdxBfh605L2hgGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUCBSgKBUFF2gTMKhCmDRwEBhTiIDpheglMDVQIJAQE?=
 =?us-ascii?q?BAQEBAQEBBgIfDgIEAQECgQODRwI1gWAlOBMCAwEBAQMCBQEBBgEBAQEBAQU?=
 =?us-ascii?q?EAgIQAQEBCA0JCCmFKTkMQwEQAYJ8gQIBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBBQKBBwU+AQEBAxIRFQgBATgPCxgCAiYCAjIlBgE?=
 =?us-ascii?q?MCAEBHoMEAYJLAy4BnSsBgSg+AiMBPwEBC4EFKYhgAQF1gTKDAQEBBXqBT4J?=
 =?us-ascii?q?2GEEJDYE3CQkBgQQqAYJpgk8RNoJuhB6BQT+BOAwDgiU1PoQlgy6CYI8/ixt?=
 =?us-ascii?q?OmhGCZ4hVkH8FBwMegniBHo0dKI1mLYUrjCSBZ5hNKIQhAgQCBAUCDgEBBYF?=
 =?us-ascii?q?qgXszGggdE4MkCUcXAg2OHhodgVKBaIJWg3uEI1Y3AgYIAQEDCXx2jSUBgRA?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2GxAAAgdxBfh605L2hgGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBSgKBUFF2gTMKhCmDRwEBhTiIDpheglMDVQIJAQEBAQEBAQEBBgIfD?=
 =?us-ascii?q?gIEAQECgQODRwI1gWAlOBMCAwEBAQMCBQEBBgEBAQEBAQUEAgIQAQEBCA0JC?=
 =?us-ascii?q?CmFKTkMQwEQAYJ8gQIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQKBBwU+AQEBAxIRFQgBATgPCxgCAiYCAjIlBgEMCAEBHoMEAYJLA?=
 =?us-ascii?q?y4BnSsBgSg+AiMBPwEBC4EFKYhgAQF1gTKDAQEBBXqBT4J2GEEJDYE3CQkBg?=
 =?us-ascii?q?QQqAYJpgk8RNoJuhB6BQT+BOAwDgiU1PoQlgy6CYI8/ixtOmhGCZ4hVkH8FB?=
 =?us-ascii?q?wMegniBHo0dKI1mLYUrjCSBZ5hNKIQhAgQCBAUCDgEBBYFqgXszGggdE4MkC?=
 =?us-ascii?q?UcXAg2OHhodgVKBaIJWg3uEI1Y3AgYIAQEDCXx2jSUBgRABAQ?=
X-IronPort-AV: E=Sophos;i="5.75,359,1589259600"; 
   d="scan'208";a="220862180"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:52:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Icoqy18oR23o7bjcqZ1z7U6P/014NQ5x31vk08dl7/O1ie/LxhEFZGufwXjGEjGQTwhN//Edkt6eDOThJ7i4G9RUJQETBRVC1kGrAJ6fPgXFtNMilRHiCSqhJNooUC3k28gnfFRryjfSStH6+6o/jIlGqtbmG6D8ORfA8grm18PTqfsVkf8CRcdFJKJ8yu9eTX2hQriW2FuOxFJPQVBBAhwT86gbtdht5cpQti3zaK3N26yMxhNJP2AaOBfcblbgw/isxnjs8rQuk577c9zJ5T4jbN8aZw5Y4t2oVkAAU88uSTfGf48iaosv+UPicEcsAJRTR2e/u4tMTSqq6BGwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBKw+y9nZZmWyWg8QvOKZFz2fblJFnmXL7ECeT86wK4=;
 b=Pi0XI8QsRLU4IAKl5jq9NtnUrAELKhQUzYcaZxQhMBttUFfe70rCO2kpwO4bqFLGiE2Cmfj5n0fWRCndERHY13HdtqReGWX13C90FV7wLHsy1CvxP6XvjwnQanlBs9UQRM+5+wIgj5Bfpk/79B3ruaVJdtaxUW+bB9L+ie9ID0cBecrTPFHHz50374s0iRDnz6yBcar+0/0H8ztSSGtZ8xvLGeEgV2ZIu1E30iTccBa0+xBKViPS4EoUZrY5c4fE3+NcT/xhlqq5DYs0gK2sHV8FAS7bvdF3FkopYj57c1p7WHboYPiZ5sXciCS9gudLFdZEj//ZvXD6kZF4o3DFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBKw+y9nZZmWyWg8QvOKZFz2fblJFnmXL7ECeT86wK4=;
 b=eLBs3nBL9hE3ynzdIfR6bYfy1xclw2hwlvpPtARt7g77TnYZjps6Fdocm315YzwRKvFyvRZkMAHIiK5+6Z2d6PeP5m1ShFSEwyvFiDoQhkzPAOkYEmkmy1oeMDb+1pRv8RNChJtZ+y/3dF7yfW+OwLvWAxFesHzlhOdRoRPyCfc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB6294.namprd06.prod.outlook.com (2603:10b6:a03:f0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 15:52:53 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::8570:7340:3a13:1f87]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::8570:7340:3a13:1f87%3]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 15:52:53 +0000
Subject: Re: [PATCH 4/4] nfs-utils: Update nfs4_unique_id module parameter
 from the nfs.conf value
To:     Steve Dickson <SteveD@RedHat.com>,
        Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <5a84777afb9ed8c866841471a1a7e3c9b295604d.camel@redhat.com>
 <115d8b45e84f3cecc9f5623e39f5078315d3ebbd.camel@redhat.com>
 <a49c78c1-1419-409b-2386-25d94afb7ca7@RedHat.com>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <5b67708a-f31c-249c-6405-43fdd278037c@math.utexas.edu>
Date:   Thu, 16 Jul 2020 10:52:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a49c78c1-1419-409b-2386-25d94afb7ca7@RedHat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::29) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by DM6PR12CA0016.namprd12.prod.outlook.com (2603:10b6:5:1c0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 15:52:52 +0000
X-Originating-IP: [67.198.113.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5707519a-3cff-436f-54f0-08d829a04cd6
X-MS-TrafficTypeDiagnostic: BYAPR06MB6294:
X-Microsoft-Antispam-PRVS: <BYAPR06MB6294E51613D511A5EEDCE892837F0@BYAPR06MB6294.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3zaGYWZW2lDBbEynSNslGuLilt0YpSztnq7AsZ8HViykOTHWsNCovoQBHnAak1a7zUDNGhuKhZCinOLxhWLLTItZpjPfkUpOpDURQFGDDCjlri3zbLhkEprgDkT/TEBC5d+ySSiheAa8qeLhKZBnb9pgxnYjnTu9n2GB+wBbUU+bO7MbOatbbaloIFZHkY5cOlnxXQ75oWktqY4Cn2CyP1gCu12ySltNmxI2sfbU3H1BraIFzOeT4WrqTewCV942TnGEr6x1udEYZz3XOdA152WbcpjJ8/Ues3Yy+Thf864rPjLWe+FKhPAYn51KVmVB+0gOUyz86caidheD3sumHVIuYwuRV9lx8Vjdu3spWXG926LAooH/+JGPVeLT+iX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(478600001)(53546011)(83380400001)(52116002)(86362001)(75432002)(31696002)(110136005)(66946007)(66476007)(16526019)(26005)(316002)(2906002)(66556008)(8676002)(15650500001)(5660300002)(31686004)(6486002)(8936002)(956004)(786003)(2616005)(16576012)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: slLR6OqOxuBG9EfyHrdIlY6hVPA0Iw5RiEqEyRphBWCvAxIzT/18JpmvlVk13JUqA8UVwxIS88+WI9YPN8qwyGNKarWD1Sw38CH/FUV1I7XQR5deuEmeV9KCsF+iMbAubjXUwDdayff5i0oACrgvD+MFf2ho7uVry2pC638N2LedUeX5unA5KVDhdyy0hpeLOEOxhJqsJ/6xPSCLQGwjnDRnkNA+5SY442mRn6oyweI5ULh7l8wMf/RRP7yHA01cly7s6Ycd89xiPkpjivyLuChKDtOI43LQ6zjX4mLkKclMBLxn3aiMDBt34z1pIB+SCQwMa4r8Wo7+4TwtChcy5E3pltHO9SsEfLsVSOe1upVkOEk0KfDd1Mt8MezOTsaduvpxfNPmcGSgw0oCAC7EgvqmY7hFa4+1LMvICul0p1+05shz50qT/yqa2/VNUO+rOXYHegMs19oRv2HBmzYPt85BE/XGfRrscetiiknVXkRqNAPvbYdOXDBjnhTYNfTz
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5707519a-3cff-436f-54f0-08d829a04cd6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 15:52:53.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/H3nlZUSgZVxVPGKidNaZqx9bA9KjbTiut6D9+e7ENEUI0mowiVpAjBI6hac2YYU4YZTFtzfUBxGG8zMgU5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB6294
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Speaking of which, it would be great if the distros (or whomever) 
stopped setting up the unit files so that rpcbind is a required service. 
This is a headache for me, as our security group flags machines running 
rpcbind and it's entirely useless if you only use NFSv4.

In fact, isn't it about time to EOL NFSv3?  <:)

On 7/15/20 12:44 PM, Steve Dickson wrote:
> Hello,
> 
> On 7/10/20 12:44 PM, Alice Mitchell wrote:
>> systemd service to grab the config value and feed it to the kernel module
> Again, I'm wondering if the systemd/README should be updated to explain
> this new script...
> 
> steved.
> 
>> ---
>>   nfs.conf                      |  1 +
>>   systemd/Makefile.am           |  3 +++
>>   systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
>>   systemd/nfs-config.service.in | 17 +++++++++++++++++
>>   4 files changed, 49 insertions(+)
>>   create mode 100755 systemd/nfs-conf-export.sh
>>   create mode 100644 systemd/nfs-config.service.in
>>
>> diff --git a/nfs.conf b/nfs.conf
>> index 186a5b19..8bb41227 100644
>> --- a/nfs.conf
>> +++ b/nfs.conf
>> @@ -4,6 +4,7 @@
>>   #
>>   [general]
>>   # pipefs-directory=/var/lib/nfs/rpc_pipefs
>> +# nfs4_unique_id = ${machine-id}
>>   #
>>   [exports]
>>   # rootdir=/export
>> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
>> index 75cdd9f5..51acdc3f 100644
>> --- a/systemd/Makefile.am
>> +++ b/systemd/Makefile.am
>> @@ -9,6 +9,7 @@ unit_files =  \
>>       nfs-mountd.service \
>>       nfs-server.service \
>>       nfs-utils.service \
>> +    nfs-config.service \
>>       rpc-statd-notify.service \
>>       rpc-statd.service \
>>       \
>> @@ -69,4 +70,6 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
>>   install-data-hook: $(unit_files)
>>   	mkdir -p $(DESTDIR)/$(unitdir)
>>   	cp $(unit_files) $(DESTDIR)/$(unitdir)
>> +	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
>> +	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
>>   endif
>> diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-export.sh
>> new file mode 100755
>> index 00000000..486e8df9
>> --- /dev/null
>> +++ b/systemd/nfs-conf-export.sh
>> @@ -0,0 +1,28 @@
>> +#!/bin/bash
>> +#
>> +# This script pulls values out of /etc/nfs.conf and configures
>> +# the appropriate kernel modules which cannot read it directly
>> +
>> +NFSMOD=/sys/module/nfs/parameters/nfs4_unique_id
>> +NFSPROBE=/etc/modprobe.d/nfs.conf
>> +
>> +# Now read the values from nfs.conf
>> +MACHINEID=`nfsconf --get general nfs4_unique_id`
>> +if [ $? -ne 0 ] || [ "$MACHINEID" == "" ]
>> +then
>> +# No config vaue found, assume blank
>> +MACHINEID=""
>> +fi
>> +
>> +# Kernel module is already loaded, update the live one
>> +if [ -e $NFSMOD ]; then
>> +echo -n "$MACHINEID" >> $NFSMOD
>> +fi
>> +
>> +# Rewrite the modprobe file for next reboot
>> +echo "# This file is overwritten by systemd nfs-config.service" > $NFSPROBE
>> +echo "# with values taken from /etc/nfs.conf" >> $NFSPROBE
>> +echo "# Do not hand modify" >> $NFSPROBE
>> +echo "options nfs nfs4_unique_id=\"$MACHINEID\"" >> $NFSPROBE
>> +
>> +echo "Set to: $MACHINEID"
>> diff --git a/systemd/nfs-config.service.in b/systemd/nfs-config.service.in
>> new file mode 100644
>> index 00000000..c5ef1024
>> --- /dev/null
>> +++ b/systemd/nfs-config.service.in
>> @@ -0,0 +1,17 @@
>> +[Unit]
>> +Description=Preprocess NFS configuration
>> +PartOf=nfs-client.target
>> +After=nfs-client.target
>> +DefaultDependencies=no
>> +
>> +[Service]
>> +Type=oneshot
>> +# This service needs to run any time any nfs service
>> +# is started, so changes to local config files get
>> +# incorporated.  Having "RemainAfterExit=no" (the default)
>> +# ensures this happens.
>> +RemainAfterExit=no
>> +ExecStart=@_libexecdir@/nfs-utils/nfs-conf-export.sh
>> +
>> +[Install]
>> +WantedBy=nfs-client.target
>>
> 
