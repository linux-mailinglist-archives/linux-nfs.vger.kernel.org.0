Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD55FB2D6
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 15:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJKND4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJKNDy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 09:03:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC577AC3F
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 06:03:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BBcirq011525;
        Tue, 11 Oct 2022 13:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OUwnqatf0eBoveUxfwjm5WGjcXAT7q+kmV9q2CFGDxk=;
 b=3aByGEhczFvP/LFpFhCC0mUh0LyJn9DfTFnGxBXLFp+mJkkIHAcfuEXIczjenbhl24Ej
 XkFcNdkf7IVwp3M3bDORG3/85w0QgiMn0ZqBhf0S5yW6NzdlgxDsJ6JUe5PJK22N1X5U
 IjCnBWTAuYvKM+XI5uL84WabohtMUTRFDNYnBqTwGdzfi4BRxsvJgS+ZbHmJhhF4337Z
 xFIzDK0RTqEeXupdTMIHFBOf488GymMGZdfDW7E+01ZZ3Nz/28caR0FBrnJEpeoki8o4
 C6zZULrtLmSHOb5c8HMSI+RaaiU2cnODR6XDETYpReEX6zG0vW+hqWKxo5bJgTS55SAQ LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3002xmnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 13:03:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BC9Dmi027700;
        Tue, 11 Oct 2022 13:03:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yna5ycw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 13:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAgzvLcki8e7SouZkhh/lbANqg/QEjYva6GhrIuiYr9OmNw1E7I4UZnPygNcwaDqjBdcgFrVuSOhDHfvqEcilJCNT89v+19s94gnKvw/bTzwQgdkAZOXEto+x/0COLQgmDmKiHfAP2WwggKQ+up0yTfBg+jkYAcLMaCsZQmuGROIMa6CHM7EhrBRpEAQHabjM7YMIsKRLiKxTojMzhdKaMNA/pAWWMUWKOUd6UJmrbPI4lhAIfyHskDSuaw1o4BlYN+UamP5J5adyXb4K/7rSgpJlGvo/fZTyRKuvqF7BSBajhE2KzQOJSbGGvEihQeeRLTtO1ptRxz7cbhxcVyBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUwnqatf0eBoveUxfwjm5WGjcXAT7q+kmV9q2CFGDxk=;
 b=CXiR9IxmLwtCv9wmhmO7aLpCCLbAL7SS0U1OG2lE4WU3nwd6CO1/eKITE29YETw8frmXKoDNOudmfmkoKXU7ClGjejNfpUg032RR2CEgxZhhCjvHWY8F44KDNdsY2F66Im3EmqF/N5M1P4PMV/1RoJKfShjeIECqGup9ggaZvYAMXxnGlNWhhcvmi1bYo6Xg8IcNQI36mvaqPERppSWIp34h8eRS3DHDJVqG0UC3G/76Ae2XHMnVlyTpYM6B0Da6rigz43PiPzkMMQlAgnid+1VuvbtIOvSeZ/l6qtX2N1VCi3/8TS7k2Jl+VYQuuZxQtgTT2M4ZDt7Zqvox5cHVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUwnqatf0eBoveUxfwjm5WGjcXAT7q+kmV9q2CFGDxk=;
 b=H+MLHWfTCk5ouNtPbzIbGEL8O5N3P/uMnYGei/x7upquR1bFygSIVfqO/LO5IltNZTXzCmGNLj7ZVBmFCEVGwXVSCRMGtus2QZYN2/xR51bSALVdk0jcNcj2A/4Ity+XBqOM70ocxbXcJCpIwE3ww8ZsuNWg9p/qU+PYWRBkcuQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5991.namprd10.prod.outlook.com (2603:10b6:8:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 13:03:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 13:03:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
Thread-Topic: [PATCH v2 5/9] NFSD: Add an NFSD_FILE_GC flag to enable
 nfsd_file garbage collection
Thread-Index: AQHY2Z+9tOD4ZItI6keTxmEzqf5zba4IUuCAgADdrIA=
Date:   Tue, 11 Oct 2022 13:03:47 +0000
Message-ID: <83423A72-6391-4B3C-87F6-55757FBACFE8@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
 <166507323630.1802.8998394314935628609.stgit@manet.1015granger.net>
 <166544582340.14457.4208476936769397056@noble.neil.brown.name>
In-Reply-To: <166544582340.14457.4208476936769397056@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB5991:EE_
x-ms-office365-filtering-correlation-id: 43c5037a-6d38-4440-3a2e-08daab890931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKfZb/ZY7/udFl9IsLSWju1k5qIIm0Bg4pmoo2zzHmeLlwSmx1nAMiXlx5aJRJYA+B3kLM0De1ZTv74q1lrkulaK/uQIkVbbZoALPJ7NM26bA481wTWKbxS9uOuvI8G5AyGTs084M0KBbdunLHjpA3x1TLE4ETeRN6EEp1d0PVMXbOZiw+ccq+i2tTemoq+ESjaMbfN2ibx+uQleD89XbzfBSG6F/WZaGZ7wM4jPgf0MQwyjXbNzv23u016IS37gmYhmUote98+65YjqPJgBv6VJsU/i+/tUJAMlXR4raIdrr2rY9Y8ytw+/o07VKKF4S+CCNKK7NL8k8BmsJJh+8XqgqzcB1r2s0FXw/0FRk89Z3QuRaI0RXWMt79+Mu/AC/VdpN2/0JSmqN0QJYv7vmDrt/Ix7A3xJeiMbDg/2uRuFKWJO8gyDx8X447Qa3+kM+z6VyQgLuw+YkXR1Ho0rn04T5jaggKxUa0d+LA9DIf+rxUMYW8HIP84JzNeGIpwlZHoOdJYEhSfJSozgDHlppSG9cUdC8zvxbtAoNaUyOCWYfe+vRBQ++VQ/+450pK4VRB2Ly5rpHEQKb8/zaE1YONkCjSfC6+mqVRCRYPpmZ4M4gd/rlwtK/gRmFlqQqGzdQOhTPReYtkDz1g/kQ0t18v+HojhBvZY7Go3ZGst7VXL+XHmifHZR+w6qV3iJgzgwt0LaAOs3gaJARSIY4nnwhj2gFJGlNLohDTwokpPWWPOeooOOyGFYZV8VaWt7T+upEG+gUSwT7+K+VW4e/mtgfiUunSZOM1wh+HUYjfMqztbD1xoa28qbG87bAxBFhpywXEo5LDrQLmvJAgkBz9WBTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(26005)(316002)(36756003)(83380400001)(33656002)(2616005)(38070700005)(71200400001)(966005)(86362001)(6486002)(2906002)(76116006)(53546011)(6512007)(66476007)(66946007)(4326008)(91956017)(66556008)(6916009)(8676002)(38100700002)(8936002)(64756008)(122000001)(41300700001)(66446008)(6506007)(186003)(5660300002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?POWi9R0DWo65byXphp1SFfCHyGe1FK+XmMCEyqKlUuYhTp5usy2e/2xMwtEs?=
 =?us-ascii?Q?hgvUCn36QQfdJMZz/JxKItpzPj8N7X30tQAMc9Y7IyjfOKTJI7ZNhE/IndPx?=
 =?us-ascii?Q?7zoSTk0XkbKBFaWWK1K1nl79+FacePd7sueUtWDuGKXK4SJgCvOfThXxJnI4?=
 =?us-ascii?Q?HUrK0SAz17Hs2PWZ8Zi+mSiNaEYgCbFR0dWHY7FGntxDLLxCpeGPv2vg8ev0?=
 =?us-ascii?Q?JhVxevzZaI5richRH2/86/yJMUMgShvgxzqBn3miA3xqW76iGyG2XLohptME?=
 =?us-ascii?Q?tZ1T9mGzFhqMM4whdx8TyzCCMPdiHQLShF2uuBKQNz/DzEFzi/OwYKYmefAp?=
 =?us-ascii?Q?VmIBDZiMsd+XVUmN5AVy4Zo1dL07T5mMUw81DWwJNI1ePQ/cJuij+RGwIcFm?=
 =?us-ascii?Q?A1wXpuz1m6EEoqBff9lajsf9yp6bavjw1wiJ+xtzn4c6vwC57nl/h43pJAky?=
 =?us-ascii?Q?fi1qPN2jhvPulHmAECRFDr+xkyEVLb91B6BZkJ2MhEQuMIwmWKLVRGIW5MuS?=
 =?us-ascii?Q?Td83q3y1dJchBVj0P/D7EP66d7GlWsw+7bD9FOcYW7UmmBQ2ISTnupZokA1K?=
 =?us-ascii?Q?JQNt9N0yafB2t99/lOOWStwP2ApNeGWjpmJsL+qabHuWv0Xeg4O0+I9soJh1?=
 =?us-ascii?Q?ty+/4+9H4fUO5frJTWQiAi8cO62AcemvWo5Eb+3PCCjsppgnjWTZxQsYYMOJ?=
 =?us-ascii?Q?kjd8s/BhgoW4+asJNCiFI33pkLguFu3kYNHOIDEzS5RFQhWIttjix5aS+Wow?=
 =?us-ascii?Q?5B2aLV1hN7lMITJHq/nByBxY8GV6MTd1CX5R6oBmsUaD0aXbyR6EIZm8NNo1?=
 =?us-ascii?Q?uMcdpPMRnbH/VOSFtxVb49S1UNTKYklBe6JdOX5eVFQ7xgs4H03ctwS+/iE7?=
 =?us-ascii?Q?+fk+1kHtquRI/iz533wxNFrCocuqIN5s5xNZbevazV56T5LkMY8YKf7kTJLY?=
 =?us-ascii?Q?nhFp5WRABkm5Xwsi5r9zrwft6g7kNiffuiKlZ4WpEOpSnB6OCpQCgp9r7aAH?=
 =?us-ascii?Q?Kp0X3beBrdx7SABsTw5X6eTA2Q8HXTzNBUpEpna4d2I8mxwIdGzLdRzM1Xdu?=
 =?us-ascii?Q?09o7531116DkQcnBeWaXv3hdA4h9CG66hXzT+pjoFEgdcEyapjLvIBso/fs5?=
 =?us-ascii?Q?rg4sPEstGwDUMKOQO6z4kw2ypDrYJ8ekdkFmv6/dNzv/nt8Z3IFtRNpmgkLw?=
 =?us-ascii?Q?tGC6ioX/W9ZFmlAIVXlf3xtf+Zy/e/S2IkERF14sc8AFbr8U1U+PfPf3yY2e?=
 =?us-ascii?Q?Xs2PecfFp6AunZFRQl+kkXVIeVzP87qoph9D1TS6r3g7IaTKRVT/ugwJ6CSX?=
 =?us-ascii?Q?wV+SZDOSYNS5zYDRvA3gVR2RAHZP0ln8fbev9auPR6bkbggZTvOL+Yun8Rwu?=
 =?us-ascii?Q?5+VVrZNxC+PXHLa0UzzlAfiBhwcvPf6esEFlCvk+T17efDmBr6a3rOx8xXCE?=
 =?us-ascii?Q?x/TEaX/8bNx0E7+nUk8BkT/9tE1BkxgG1HALDqGTOMfbfdp89XafbkZoH7Jw?=
 =?us-ascii?Q?DlPwI/sXbpuFn/sERMOdg1GYJ4o1RYDaU+DTjiaKs3nUjeHSmTmlLzA0O6UY?=
 =?us-ascii?Q?U06k5gzqWirSIrR6zLxr6cjxH6SmcFr9w5QgcBlJ0c5R66IbywqDq9RNovlq?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2ABC4C98B6010F4F82BB95551B42BB58@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c5037a-6d38-4440-3a2e-08daab890931
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 13:03:47.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4IeDIf5mCVLIJhCxPjg3qJI2hmLlo7sipA1Iixl+aFkjxvrNjAewT9LijoQvcswf2ICahbPuKqo/k21uZQlVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_07,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110074
X-Proofpoint-ORIG-GUID: o7AnDCewwRbLpxJAT2Vun_Eti5WkIU3o
X-Proofpoint-GUID: o7AnDCewwRbLpxJAT2Vun_Eti5WkIU3o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Oct 10, 2022, at 7:50 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 07 Oct 2022, Chuck Lever wrote:
>> NFSv4 operations manage the lifetime of nfsd_file items they use by
>> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
>> garbage collected.
>>=20
>> Introduce a mechanism to enable garbage collection for nfsd_file
>> items used only by NFSv2/3 callers.
>>=20
>> Note that the change in nfsd_file_put() ensures that both CLOSE and
>> DELEGRETURN will actually close out and free an nfsd_file on last
>> reference of a non-garbage-collected file.
>>=20
>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
>> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++=
------
>> fs/nfsd/filecache.h |    3 +++
>> fs/nfsd/nfs3proc.c  |    4 ++-
>> fs/nfsd/trace.h     |    3 ++-
>> fs/nfsd/vfs.c       |    4 ++-
>> 5 files changed, 63 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index b7aa523c2010..01c27deabf83 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
>> 	struct net			*net;
>> 	const struct cred		*cred;
>> 	unsigned char			need;
>> +	unsigned char			gc:1;
>> 	enum nfsd_file_lookup_type	type;
>> };
>>=20
>> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_com=
pare_arg *arg,
>> 			return 1;
>> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>> 			return 1;
>> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>> +			return 1;
>> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>> 			return 1;
>> 		break;
>> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, un=
signed int may)
>> 		nf->nf_flags =3D 0;
>> 		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>> 		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>> +		if (key->gc)
>> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>> 		nf->nf_inode =3D key->inode;
>> 		/* nf_ref is pre-incremented for hash table */
>> 		refcount_set(&nf->nf_ref, 2);
>> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>> 	}
>> }
>>=20
>> +static void
>> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
>> +{
>> +	if (nfsd_file_unhash(nf))
>> +		nfsd_file_put_noref(nf);
>> +}
>> +
>> void
>> nfsd_file_put(struct nfsd_file *nf)
>> {
>> 	might_sleep();
>>=20
>> -	nfsd_file_lru_add(nf);
>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
>> +		nfsd_file_lru_add(nf);
>> +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>> +		nfsd_file_unhash_and_put(nf);
>> +
>> 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>> 		nfsd_file_flush(nf);
>> 		nfsd_file_put_noref(nf);
>> -	} else if (nf->nf_file) {
>> +	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D=
 1) {
>> 		nfsd_file_put_noref(nf);
>> 		nfsd_file_schedule_laundrette();
>> 	} else
>> @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
>>=20
>> static __be32
>> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
>> +		     unsigned int may_flags, struct nfsd_file **pnf,
>> +		     bool open, int want_gc)
>> {
>> 	struct nfsd_file_lookup_key key =3D {
>> 		.type	=3D NFSD_FILE_KEY_FULL,
>> 		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
>> 		.net	=3D SVC_NET(rqstp),
>> +		.gc	=3D want_gc,
>> 	};
>> 	bool open_retry =3D true;
>> 	struct nfsd_file *nf;
>> @@ -1117,14 +1135,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 	 * then unhash.
>> 	 */
>> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>> -		if (nfsd_file_unhash(nf))
>> -			nfsd_file_put_noref(nf);
>> +		nfsd_file_unhash_and_put(nf);
>> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>> 	smp_mb__after_atomic();
>> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>> 	goto out;
>> }
>>=20
>> +/**
>> + * nfsd_file_acquire_gc - Get a struct nfsd_file with an open file
>> + * @rqstp: the RPC transaction being executed
>> + * @fhp: the NFS filehandle of the file to be opened
>> + * @may_flags: NFSD_MAY_ settings for the file
>> + * @pnf: OUT: new or found "struct nfsd_file" object
>> + *
>> + * The nfsd_file object returned by this API is reference-counted
>> + * and garbage-collected. The object is retained for a few
>> + * seconds after the final nfsd_file_put() in case the caller
>> + * wants to re-use it.
>> + *
>> + * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>> + * network byte order is returned.
>> + */
>> +__be32
>> +nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		     unsigned int may_flags, struct nfsd_file **pnf)
>> +{
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 1);
>> +}
>> +
>> /**
>>  * nfsd_file_acquire - Get a struct nfsd_file with an open file
>>  * @rqstp: the RPC transaction being executed
>> @@ -1132,6 +1171,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>  * @may_flags: NFSD_MAY_ settings for the file
>>  * @pnf: OUT: new or found "struct nfsd_file" object
>>  *
>> + * The nfsd_file_object returned by this API is reference-counted
>> + * but not garbage-collected. The object is released one RCU grace
>> + * period after the final nfsd_file_put().
>> + *
>>  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>>  * network byte order is returned.
>>  */
>> @@ -1139,7 +1182,7 @@ __be32
>> nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		  unsigned int may_flags, struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 0);
>> }
>>=20
>> /**
>> @@ -1149,6 +1192,10 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>>  * @may_flags: NFSD_MAY_ settings for the file
>>  * @pnf: OUT: new or found "struct nfsd_file" object
>>  *
>> + * The nfsd_file_object returned by this API is reference-counted
>> + * but not garbage-collected. The object is released immediately
>> + * one RCU grace period after the final nfsd_file_put().
>=20
> While that last sentence is correct, I think it is missing the point.
> The reference to grace periods is really an internal implementation
> details.

Fair enough, document policy and not implementation. I'll rework this
based on your suggestion below.


> The important point is that on final nfsd_file_put(), the object is
> removed from the hash table.  This contrasts with the other version
> where on final nfsd_file_put(), the object is added to the lru.
>=20
> The code all seems good, just the comment seemed odd.
>=20
> Thanks,
> NeilBrown
>=20
>=20
>> + *
>>  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>>  * network byte order is returned.
>>  */
>> @@ -1156,7 +1203,7 @@ __be32
>> nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		 unsigned int may_flags, struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, 0);
>> }
>>=20
>> /*
>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> index f81c198f4ed6..0f6546bcd3e0 100644
>> --- a/fs/nfsd/filecache.h
>> +++ b/fs/nfsd/filecache.h
>> @@ -38,6 +38,7 @@ struct nfsd_file {
>> #define NFSD_FILE_HASHED	(0)
>> #define NFSD_FILE_PENDING	(1)
>> #define NFSD_FILE_REFERENCED	(2)
>> +#define NFSD_FILE_GC		(3)
>> 	unsigned long		nf_flags;
>> 	struct inode		*nf_inode;	/* don't deref */
>> 	refcount_t		nf_ref;
>> @@ -55,6 +56,8 @@ void nfsd_file_put(struct nfsd_file *nf);
>> struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>> void nfsd_file_close_inode_sync(struct inode *inode);
>> bool nfsd_file_is_cached(struct inode *inode);
>> +__be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		  unsigned int may_flags, struct nfsd_file **nfp);
>> __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		  unsigned int may_flags, struct nfsd_file **nfp);
>> __be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index d12823371857..6a5ad6c91d8e 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -779,8 +779,8 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>> 				(unsigned long long) argp->offset);
>>=20
>> 	fh_copy(&resp->fh, &argp->fh);
>> -	resp->status =3D nfsd_file_acquire(rqstp, &resp->fh, NFSD_MAY_WRITE |
>> -					 NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> +	resp->status =3D nfsd_file_acquire_gc(rqstp, &resp->fh, NFSD_MAY_WRITE=
 |
>> +					    NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> 	if (resp->status)
>> 		goto out;
>> 	resp->status =3D nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 9ebd67d461f9..4921144880d3 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -742,7 +742,8 @@ DEFINE_CLID_EVENT(confirmed_r);
>> 	__print_flags(val, "|",						\
>> 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>> 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>> -		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>> +		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
>> +		{ 1 << NFSD_FILE_GC,		"GC"})
>>=20
>> DECLARE_EVENT_CLASS(nfsd_file_class,
>> 	TP_PROTO(struct nfsd_file *nf),
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 44f210ba17cc..89d682a56fc4 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1060,7 +1060,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>> 	__be32 err;
>>=20
>> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
>> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
>> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_READ, &nf);
>> 	if (err)
>> 		return err;
>>=20
>> @@ -1092,7 +1092,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *=
fhp, loff_t offset,
>>=20
>> 	trace_nfsd_write_start(rqstp, fhp, offset, *cnt);
>>=20
>> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_WRITE, &nf);
>> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_WRITE, &nf);
>> 	if (err)
>> 		goto out;

--
Chuck Lever



