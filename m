Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517094D8890
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiCNPxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiCNPxP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 11:53:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760F533E14
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 08:52:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EFSpD2001435;
        Mon, 14 Mar 2022 15:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fafDEVVDDi3w/DviUUdYqrk/KuTTpuldM9HOq4qwNTQ=;
 b=PWisGRo/qtcIa/AEIPzYECQI3tVbRNpkPuuFD66mbsTE1Huv2m0kGTe2xopqDnlX6Vhz
 6S9xyzgV35t6gT2xjmkwyInsyMtmStiXsoaw+O/KLT42EC/WeppWG7fBUWGua2az0XtF
 PP2NnszJDXzN+vDMokU5aVXo5YW2v2xryE7zE/M1Pz6LtXErKhrZ2ufzSmOdRfiGyBu2
 yQ9RnzH/03SffWz7VOHec7ptjj4HYTY2OMLS8e39FQrNeljXcx6/U7E275c6LwgJXJKj
 ZdpmlNLAmK/4HGbUs9W72QfctvQDCArMBN9EmZP5DmQrIAHaC/y0+NugHoRHwbU38P/2 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu0qd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 15:51:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EFocQq175990;
        Mon, 14 Mar 2022 15:51:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3020.oracle.com with ESMTP id 3et656ug6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 15:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clM6kQT4sBeRmETJMTqp73g8zJFSq/twk9gT3Bh+n5tgum0QizM60yUf7Y1ZpUuArpuTvpd4z3O0oj4AeLmPH7UcrJrwHmidi5R+f8UmpGH1fpAITqdaXxl2tUdKuFB61Gw+Pqd6bXt7Egp2Lx5gure7K7keFQe05m2uStO1HeqAiGTi7VcejyTzo6sacyY559WGs39/nK8e+7TLY+qWf+M1lDe8Dt/BPpHAAfCEp1HycqkBxsWFhQapk+l2aoad5nCq26FpCj0JKTTJyYr06A50wV8op1WdRyVYXW6Z1NL6qJ2iH/xxJ5JBm9dPqF9+Z2XzCpTPobiPDZzj9ZJmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fafDEVVDDi3w/DviUUdYqrk/KuTTpuldM9HOq4qwNTQ=;
 b=IRqyhZQjrkJW55iz8sS8epEUOmsB5fsS0gS5oooeY5F2zDkk0qhRo2hOfMpZds9CUN/UtLnA/HLHO5Bjk/qA4+6UTHI14C/ILUPX2U+QniTWCmJikFyeIifVWsSgXh5ZqlRgwC+gdS4k1dcrbQM6sOrgVNondLCr0F8SnHm5ufnNQ7L9kcz5mNYjuRE4E49EEcaSGSZaQy0EWdGJ6/QF41r+Wb14GQ7KMeDiBtExqaRa+0uaCsN5XR2wDCsfZQR5HSJ+lPXifGgvhQy/lYpmO8QlRNPu1AJZ6VMNkQWL8M9vqbtMfJvf3Hqj/gXrrzUCYYbZKl615JApK/ohZWr6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fafDEVVDDi3w/DviUUdYqrk/KuTTpuldM9HOq4qwNTQ=;
 b=cqYZ75XLAtoThQ3NVV3nPtvKoZmJGHtcFUIakl46AvSR9DDawLQvd6+X0+/t29VgBwRS05GhCOehOWs7CXL65Bs6/TIvgH8ZpFVCjVPowAe1LxjstZDmcWAeJ9mSZfkmGZzegfgj2lpLuVYGaTUqiZWhY07OlJdB8KDX2k1w66Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1333.namprd10.prod.outlook.com (2603:10b6:903:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 15:51:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 15:51:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Topic: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Index: AQHYNz9tXzp0vUT6Z02tg1tG8znMeKy/CFqA
Date:   Mon, 14 Mar 2022 15:51:54 +0000
Message-ID: <ED6618CE-EC09-448D-904C-F34FCE8E8935@oracle.com>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>
In-Reply-To: <164721984672.11933.15475930163427511814@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65f4ad94-f9a1-4ef9-9a28-08da05d2901a
x-ms-traffictypediagnostic: CY4PR10MB1333:EE_
x-microsoft-antispam-prvs: <CY4PR10MB13339EDDB617B90721525016930F9@CY4PR10MB1333.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJqZ0YIZY6SK31vnncSsy6Ui2fBDg9Muz+hlHsv7I+KfqhDiNaC6q+5Di74iN+NX6k08eHBv3Z5uIunNyHoTVco103yOi8vS/0d8ofasFLNj/9fjt9AjcPcVW9PVfxpJ2mHPT1H/Rq1GGCDCpoFnSnsUxDnw+BVuXHfbeGeu4PJaSJAhTT9iK+i7UCaWnV3uhlEGvq1LwulTQe6KDNEQ2IWsRvsNsyn+3s8YoEYpXB9rKZSeUkyAvosbyjUOEp+RnNHAu+zUuHYGZmNSvImR33zXiUm1u7MLhOK3Pxsam1/0IiO3xMBalsdQ9Tq5uXMKk0fPk+bRCnoHvOPSDTljOBNDAP4P4SbPAGCFg2QbVazPXgThFR0P6AUGqeET/nu3ofvAO0qt4AZfWrXqu7dUnOCCVOn4Ph6P824oSivOwaHf8jJeRWRUahpLIzjOH/x5/HewQm8778LlCZ5Xt869HHPvutipVuVUv9RgdJfCs4JHqTtOwp8yiBb1Qpovi9Dnhw0XOyJCPN/Cyv/Z7Bnzbz1xxTRXC3RR3Ld8JQeRy7J/1mtL4xbhsA8QWLEVGAR+rQLBug4KrO3UtEPmpBUVw18Nmxa7zdLhQdz4xN+TDp4MMtWHUdW4cjJ/JNwDvlw3kc+uzYZ2VSiabs1cB9cDbELaXuGO1XgwBLQkhGRChV6+gTXNoiwhhPnzNgQfiWr8gimfCggbaMMbCwJR9BJaJGRj3ipVzU7QgVeUXvs9ln7oocnElGrxFc/EQVVnQqOs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(5660300002)(36756003)(66946007)(66556008)(66476007)(66446008)(76116006)(91956017)(8676002)(4326008)(64756008)(54906003)(6916009)(33656002)(316002)(8936002)(83380400001)(38070700005)(2616005)(71200400001)(186003)(26005)(122000001)(508600001)(86362001)(53546011)(6512007)(6486002)(6506007)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OTkc+9jQ8AdgBhO2FeUZQ4/TRFS16CGK30ZokCFfqOxlv45t138WiRx6WLA1?=
 =?us-ascii?Q?cdZRnEf7eHJdTCvL7Jt2ox2+GfT2DsdNloZaSy1JcrL/p8szacsHCThOU8lq?=
 =?us-ascii?Q?ae+2fF6urr7DP2U9KbODMH00GMt1SbQg8Z7JUEPcq7d3Hp7Mpg0oSYL8VIGS?=
 =?us-ascii?Q?athBw4TwnW6z2cOb0VwXvvKBa2UvGdNEWCA6d6hRIn7K+22deaT7BwH8lDH0?=
 =?us-ascii?Q?uFUj0DpU7Sw/CfBYa/XqudTreYdUhNRl7yJRQXTZ5TKt0GxsJZGU0xFCnmpJ?=
 =?us-ascii?Q?ZRUohBbfr2mV9KsEk36Iq7PD6X+460tp2vmb2oNldzLK2VaXcxT80eTluaGk?=
 =?us-ascii?Q?63jlhWeNKshi1AjAiutaRZgvJY/cGDPAqunkStywQQ2SMVZGx88kj+BOmZI/?=
 =?us-ascii?Q?N0xeFHUb29L2Js0V/XIbdEV+htxvVpi5ORxgrXirc1VKBzkrZ0gcrEO1hDXY?=
 =?us-ascii?Q?0suf+1WPIoEJlVsLV/9z7Aot7ahQAageHcf2Y63Y/PZ7Cl6pltWeKO+j6dO6?=
 =?us-ascii?Q?xJVZwyKqhKgPD3TdaX5B5Z6F8A2e9lIC5tiN5UO6WCnNloXbBaKcEEYDOPPC?=
 =?us-ascii?Q?hpZczwRVMST9gJ3CErnl8PKVrabCJTC6c7am1ouj0ciqmuQtf95sAWDJ0KS/?=
 =?us-ascii?Q?VVcsEjKSrIn3ZC5DJsA992r4/ARIJi3q3RhvfJd2yD90tXqcNub1+ZdZ1HnD?=
 =?us-ascii?Q?9rR6hWNkN3DycAuJjHT4HnxpWkjC4p4+qHxkaZ8lEzGYFGrzq3a8g5GB9+Co?=
 =?us-ascii?Q?hD+3GtTIOLWWvfaGJENXdc92nMu6yFN9cnMsYXDEsO72xxKmkvjMpc5baE7a?=
 =?us-ascii?Q?McScgMRp6RFfHRBMuaty4AbOiR9HsCkvQL6LNdYFPqM32ylmNDFXk4FYGIs1?=
 =?us-ascii?Q?RHjJYycXKzlAKlcfcdNKkTetCKNcCHLyWAGbmcH0bdsxX9D2rdSBqPWF4swh?=
 =?us-ascii?Q?6ksBNn7NekU8FDnoW4p8CtINu9mJjvVfT7mh2N6gPk+5ukzP0faqceOgy2gG?=
 =?us-ascii?Q?AfkpxZf2s3ztZMvBko/GoGMsTouhZrEJo5l4d8lYM+d8AEP11a99oYbG0xWm?=
 =?us-ascii?Q?ZLJ2CyP+RGC6ABDSGnfzcmo8sdetlRB19HGKNKBYAPSI3i77fFgbi63FcRpi?=
 =?us-ascii?Q?5+gziBu9EjOjiFPuvUmR3QDrqMc1UBmvdcWCJXCdmDQ/VC5Laa6N2VWcDmX+?=
 =?us-ascii?Q?NeHwyIG/wKVisQ/2vSHmu9J3W7FQ5TmM8wFlKfltwCx9MQ4DUybMPWURDeGY?=
 =?us-ascii?Q?QbLMnGFsPX+acxVCpO4JL6jubGjlTwU/2VqKRZjP0SCd2FH86E6wRT0WBxIT?=
 =?us-ascii?Q?sAtS+91MAmzGHJQwKcdYgA1CzZb1hygEWWX1f6i/kJ/uKG+cXSIby5i9FQJe?=
 =?us-ascii?Q?DNNLbRbnnRv2iiA4IgNvSMNzCP/3HybPffh1jfjG+l2MDwuxuyOv6JcUbRdt?=
 =?us-ascii?Q?ZcTTwMrN9lFWPkrAluhgRc57ztLNcX8n6Un07dvLtCIiwn2H0Fp8lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08CC36C742BDB14EA0B72F9E5857D649@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f4ad94-f9a1-4ef9-9a28-08da05d2901a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 15:51:54.4342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXqF3zlxxgOuidLl2pNE0qDOf5SRgsxatp/Jz/eHfZS6+WmFqE9FOwx1dn5CDDNdu/qMMWYLIeoV2pPAq+ZBJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1333
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140100
X-Proofpoint-GUID: jaVn9c25O0E-smJlAoxPNt21G7WA2JK2
X-Proofpoint-ORIG-GUID: jaVn9c25O0E-smJlAoxPNt21G7WA2JK2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

> On Mar 13, 2022, at 9:04 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> When mounting NFS filesystem in a network namespace using v4, some care
> must be taken to ensure a unique and stable client identity.  Similar
> case is needed for NFS-root and other situations.
>=20
> Add documentation explaining the requirements for the NFS identity in
> these situations.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>=20
> I think I've address most of the feedback, but please forgive and remind
> if I missed something.
> NeilBrown
>=20
> utils/mount/nfs.man | 109 +++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 108 insertions(+), 1 deletion(-)
>=20
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index d9f34df36b42..5f15abe8cf72 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -1,7 +1,7 @@
> .\"@(#)nfs.5"
> .TH NFS 5 "9 October 2012"
> .SH NAME
> -nfs \- fstab format and options for the
> +nfs \- fstab format and configuration for the
> .B nfs
> file systems

Suggest "configuration for nfs file systems" (remove "the")


> .SH SYNOPSIS
> @@ -1844,6 +1844,113 @@ export pathname, but not both, during a remount. =
 For example,
> merges the mount option
> .B ro
> with the mount options already saved on disk for the NFS server mounted a=
t /mnt.
> +.SH "NFS CLIENT IDENTIFIER"
> +NFSv4 requires that the client present a unique identifier to the server
> +to be used to track state such as file locks.  By default Linux NFS uses
> +the host name, as configured at the time of the first NFS mount,
> +together with some fixed content such as the name "Linux NFS" and the
> +particular protocol version.  When the hostname is guaranteed to be
> +unique among all client which access the same server this is sufficient.
> +If hostname uniqueness cannot be assumed, extra identity information
> +must be provided.

The last sentence is made ambiguous by the use of passive voice.

Suggest: "When hostname uniqueness cannot be guaranteed, the client
administrator must provide extra identity information."

I have a problem with basing our default uniqueness guarantee on
hostnames "most of the time" hoping it will all work out. There
are simply too many common cases where hostname stability can't be
relied upon. Our sustaining teams will happily tell us this hope
hasn't so far been born out.

I also don't feel that nfs(5) is an appropriate place for this level
of detail. Documentation/filesystems/nfs/ is more appropriate IMO.
In general, man pages are good for quick summaries, not for
explainers. Here, it reads like "you, a user, are going to have to
do this thing that is like filling out a tax form" -- in reality it
should be information that should be:

 - Ignorable by most folks
 - Used by distributors to add value by automating set up
 - Used for debugging large client installations

Maybe I'm just stating this to understand the purpose of this
patch, but it could also be used as an "Intended audience"
disclaimer in this new section.


> +.PP
> +Some situations which are known to be problematic with respect to unique
> +host names include:

A little wordy.

Suggest: "Situations known to be problematic with respect to unique
hostnames include:"

If this will eventually become part of nfs(5), I would first run
this patch by documentation experts, because they might have a
preference for "hostnames" over "host names" and "namespaces" over
"name-spaces". Usage of these terms throughout this patch is not
consistent.


> +.IP \- 2
> +NFS-root (diskless) clients, where the DCHP server (or equivalent) does
> +not provide a unique host name.

Suggest this addition:

.IP \- 2

Dynamically-assigned hostnames, where the hostname can be changed after
a client reboot, while the client is booted, or if a client often=20
repeatedly connects to multiple networks (for example if it is moved
from home to an office every day).


> +.IP \- 2
> +"containers" within a single Linux host.  If each container has a separa=
te
> +network namespace, but does not use the UTS namespace to provide a uniqu=
e
> +host name, then there can be multiple effective NFS clients with the
> +same host name.
> +.IP \=3D 2

.IP \- 2


> +Clients across multiple administrative domains that access a common NFS
> +server.  If assignment of host name is devolved to separate domains,

I don't recognize the phrase "assignment is devolved to separate domains".
Can you choose a friendlier way of saying this?


> +uniqueness cannot be guaranteed, unless a domain name is included in the
> +host name.
> +.SS "Increasing Client Uniqueness"
> +Apart from the host name, which is the preferred way to differentiate
> +NFS clients, there are two mechanisms to add uniqueness to the
> +client identifier.
> +.TP
> +.B nfs.nfs4_unique_id
> +This module parameter can be set to an arbitrary string at boot time, or
> +when the=20
> +.B nfs
> +module is loaded.  This might be suitable for configuring diskless clien=
ts.

Suggest: "This is suitable for"


> +.TP
> +.B /sys/fs/nfs/client/net/identifier
> +This virtual file (available since Linux 5.3) is local to the network
> +name-space in which it is accessed and so can provided uniqueness betwee=
n
> +network namespaces (containers) when the hostname remains uniform.

^provided^provide

^between^amongst

and the clause at the end confused me.

Suggest: "in which it is accessed and thus can provide uniqueness
amongst network namespaces (containers)."


> +.RS
> +.PP
> +This value is empty on name-space creation.
> +If the value is to be set, that should be done before the first
> +mount.  If the container system has access to some sort of per-container
> +identity then that identity, possibly obfuscated as a UUID is privacy is
> +needed, can be used.  Combining the identity with the name of the
> +container systems would also help.

I object to recommending obfuscation via a UUID.

1. This is confusing because there has been no mention of any
   persistence requirement so far. At this point, a reader
   might think that the client can simply convert the hostname
   and netns identifier every time it boots. However this is
   only OK to do if these things are guaranteed not to change
   during the lifetime of a client. In a world where a majority
   of systems get their hostnames dynamically, I think this is
   a shaky foundation.

2. There's no requirement that this uniquifier be in the form
   of a UUID anywhere in specifications, and the Linux client
   itself does not add such a requirement. (You suggested
   before that we should start by writing down requirements.
   Using a UUID ain't a requirement).

   Linux chooses to implement its uniquifer with a UUID because
   it is assumed we are using a random UUID (rather than a
   name-based or time-based UUID). A random UUID has strong
   global uniqueness guarantees, which guarantees the client
   identifier will always be unique amongst clients in nearly
   all situations for nearly no cost.

If we want to create a good uniquifier here, then combine the
hostname, netns identity, and/or the host's machine-id and then
hash that blob with a known strong digest algorithm like
SHA-256. A man page must not recommend the use of deprecated or
insecure obfuscation mechanisms.

The man page can suggest a random-based UUID as long as it
states plainly that such UUIDs have global uniqueness guarantees
that make them suitable for this purpose. We're using a UUID
for its global uniqueness properties, not because of its
appearance.


>  For example:
> +.RS 4
> +echo "ip-netns:`ip netns identify`" \\
> +.br
> +   > /sys/fs/nfs/client/net/identifier=20
> +.br
> +uuidgen --sha1 --namespace @url  \\
> +.br
> +   -N "nfs:`cat /etc/machine-id`" \\
> +.br
> +   > /sys/fs/nfs/client/net/identifier=20
> +.RE
> +If the container system provides no stable name,
> +but does have stable storage,

Here's the first mention of "stable". It needs some
introduction far above.


> then something like
> +.RS 4
> +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
> +.br
> +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
> +.RE
> +would suffice.
> +.PP
> +If a container has neither a stable name nor stable (local) storage,
> +then it is not possible to provide a stable identifier, so providing
> +a random identifier to ensure uniqueness would be best
> +.RS 4
> +uuidgen > /sys/fs/nfs/client/net/identifier
> +.RE
> +.RE
> +.SS Consequences of poor identity setting

This section provides context to understand the above technical
recommendations. I suggest this whole section should be moved
to near the opening paragraph.


> +Any two concurrent clients that might access the same server must have
> +different identifiers for correct operation, and any two consecutive
> +instances of the same client should have the same identifier for optimal
> +crash recovery.

Also recovery from network partitions.


> +.PP
> +If two different clients present the same identity to a server there are
> +two possible scenarios.  If the clients use the same credential then the
> +server will treat them as the same client which appears to be restarting
> +frequently.  One client may manage to open some files etc, but as soon
> +as the other client does anything the first client will lose access and
> +need to re-open everything.

This seems fuzzy.

1. If locks are lost, then there is a substantial risk of data
   corruption.

2. Is the client itself supposed to re-open files, or are
   applications somehow notified that they need to re-open?
   Either of these scenarios is fraught -- I don't believe any
   application is coded to expect to have to re-open a file
   due to exigent circumstances.


> +.PP
> +If the clients use different credentials, then the second client to
> +establish a connection to the server will be refused access.  For=20
> +.B auth=3Dsys
> +the credential is based on hostname, so will be the same if the
> +identities are the same.  With
> +.B auth=3Dkrb
> +the credential is stored in=20
> +.I /etc/krb5.keytab
> +and will be the same only if this is copied among hosts.

This language implies that copying the keytab is a recommended thing
to do. It's not. I mentioned it before because some customers think
it's OK to use the same keytab across their client fleet. But obviously
that will result in lost open and lock state.=20

I suggest rephrasing this last sentence to describe the negative lease
recovery consequence of two clients happening to share the same host
principal -- as in "This is why you shouldn't share keytabs..."


> +.PP
> +If the identity is unique but not stable, for example if it is generated
> +randomly on each start up of the NFS client, then crash recovery is
> +affected.  When a client shuts down uncleanly and restarts, the server
> +will normally detect this because the same identity is presented with
> +different boot time (or "incarnation verifier"), and will discard old
> +state.  If the client presents a different identifier, then the server
> +cannot discard old state until the lease time has expired, and the new
> +client may be delayed in opening or locking files that it was
> +previously accessing.
> .SH FILES
> .TP 1.5i
> .I /etc/fstab
> --=20
> 2.35.1
>=20

--
Chuck Lever



