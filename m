Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3260BA41
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 22:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiJXUa7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 16:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiJXUaK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 16:30:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9EFAA77
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 11:42:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFYVko029539;
        Mon, 24 Oct 2022 17:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aDMiJVFKuCii1BSPtnfdBblV8HEHu7kN1h0ZZAiBGEo=;
 b=bUZoZvR6JYXPTxWJxv+aP8EOoTPuxeS2py2m7BltIN3RmCDSlotMDpoN+ufM9Wap5yL2
 oy2mqX0WocG380S+nsLCHGU9/47LF/fu1PT4enmhYp64gcGKdZ5L3JySZOykbwfx3QdW
 IjIVTSeatBvYD0bt3AYMzf43XWRNHok2rL4aYFhXlY3Zv3RnxCuXUlvV/Bs2MBp32Sy5
 VrNzLIv5bo83xy0J/wPqGkxMcj9sHx3rN3JVgegwdv+Za1/Fv65kSt3AhISM120uDfvJ
 360jZ0wZtZk/SuUkv93JtDhQIQNwCoBG9/sKZCaNss1ndGM5UxQAj3crPlTBCTYJbICJ Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2va23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:06:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGHElm012834;
        Mon, 24 Oct 2022 17:06:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3swpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:06:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiqwMVjXjCv0LqK8YlQHldxebqx33pnnLDSb2t01ygKqrE+mZt9BkCr4y2h7Q8iqTGI3hfNpKcsRzaYpocvlFWzdAePZyDOkYQNJkAXpLuuHfFcRodcH4ShdgGo0+dvWgy4xUdk2t4z+Up/qh2zuCJY1yGBdzcMx5JFYcSUaMJ3L4T24IFwZGTUvP1bIIjNMWaJXMHan9GB05gXJ6ZDGLJX9pSdlDjVtSS76Rf9YiaBVVfjfZmdTvQazG4M80JOhevkl3+xM1Pn9PdmkB4sO8LpkUa/RQunKc8MHo98/x7V+WJD7YMMV1s+XY/GXe85wNDTbYZXEjyfcubyYB9BXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDMiJVFKuCii1BSPtnfdBblV8HEHu7kN1h0ZZAiBGEo=;
 b=i/QXm5DVRh+vLpmpNIzX4qCoAhJO3I0WjA+Y215pHChaYxq4KP/DutVjgLljjgGxv5x6hxpaEGNK+7E67BUkmEJP5HIwVedqjOYEMehOTzkg58V8rbFJda7q31FJwMF9qrkCO7zBu70dDAUPt4Dl2bTXMSyukSVKYIHP73uJ9m8/e2h5gpZ0zK93fnILPU0KN9RzgbrcFg9HoggJDhPGSnFfgHE1x1wA5DW4idQfugvu0M76AFeecgHkoYDIvaS3EWPaH128Kc3opJx9MSw8+xrwFImpAJaAPqBnC++Psry59c30bPO8EMKsFJkyO9urvyvaCzkVcfK4dxFl8ERO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDMiJVFKuCii1BSPtnfdBblV8HEHu7kN1h0ZZAiBGEo=;
 b=PlYtUhFItQVT6wGQlAcW5efJtcL0loHicFW9RWY8Zs8tUyrI3K3aYUcEWYCRfdbC2c7n4yWwhfPd1XYVsyAjI3OwQIaPn5hkVoGN6ROVM/1LP2qzi8NUHMx136o+FUWmdy96IaY1ZBSF1XBgsllGn7UE57dfAydH7TAXR2rRk44=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6549.namprd10.prod.outlook.com (2603:10b6:510:227::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Mon, 24 Oct
 2022 17:06:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:06:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY4ywcCv9nfMlOd0+Wa/Y/m9MOsq4VmJcAgAAuS4CABw1rAIAA+1iA
Date:   Mon, 24 Oct 2022 17:06:46 +0000
Message-ID: <BED2E598-22F3-4519-A526-67FDDA906754@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
 <cdad5af44b1c62c8e2ceae27cb2b646f7b2ec0bd.camel@poochiereds.net>
 <1DE04392-E8C9-4D39-BF23-BD1A59DB4FE3@oracle.com>
 <166657723034.12462.8422170607830380805@noble.neil.brown.name>
In-Reply-To: <166657723034.12462.8422170607830380805@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6549:EE_
x-ms-office365-filtering-correlation-id: 33227dfc-a221-44e2-46a8-08dab5e221f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5sNFJy2vUV1qPBvgI6jEqk1TeYeHz+Lne/AqTOJDXj2/dDFHDp/eaSPJa3AhczHz2x7Bc9KWJvpSQaEuFMYm9n2VZDxo3KLVGLWkNyREiLFMHlKEDyv01aVPCmekebb0HNpz5e/Ldh2jM+LMMqfk9wMVCI4Bk5gLFnQ8Qhx//rx+2ykmJA+RJQHqwEx2s7nwWTGHjuj+3mEW8PYgKxtVpIWm6ZdbcKGtuPxUGD8NuUbKW5pyaq0zpZ0/eIKzphfU0SIaKYokKcPZNzQ7a1ry9gNKN59v9/QLy8R3aPhGDyR1JvTQOhxDgYLDDoSrg0djvNiUFLI69g2wZTA06qtlacfDlD6fDDFxIgHoKGomC+lYWdsQH6UYxIYYcV1RhVSfJF3F1bc+9zclU+UFGMDQB0qd0JltPRGGd/9mJHKqBgfAllH8XxoVAzohccG3ZyV1RRE+HP5Qc3UMPqWec6ZEhVfFcVPA9PlVoxIAY/oC2UpVmO1w8wacL4tx08dN9ZzS2TKrivKvV4nhIVsrUA3H0ruNAfTbZLLwQuWLLxH6jd+V26t6ITwF5PSGrjqCkTda3wHGVS99JTqjL/54By/IvrnCoLsmcm0CRDixrVc+4msVK9NozjahKmBGjHIxPH3TK0LDzyLIfv/hYLr9fRqYiD65h3nTQdjzGg/wGh53hd0g+aGQrYNtSjcJxbi9Xp8N/DR6IglpegeCUt90fu+sdyIVhGNe6ZXF8sbU2xwovHGFE0N4luznrFr3NPjQqYPxRUPoPMDgnw+86LBhAnlkyAkXYahX+GK0R1wjVtqUM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(38100700002)(6486002)(122000001)(71200400001)(478600001)(38070700005)(316002)(6916009)(54906003)(26005)(4326008)(76116006)(91956017)(66446008)(8676002)(86362001)(6512007)(41300700001)(83380400001)(53546011)(2906002)(5660300002)(8936002)(186003)(33656002)(2616005)(36756003)(66946007)(66476007)(66556008)(64756008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zpmnqIIP5iiwIKjhjuyvSHbmTwuYCHpfalc/nJ98K4bjmXuqlIugn3cNnjeo?=
 =?us-ascii?Q?FU7UPraObfLXW9JhHZ4V6DZS9mjeIAQSfzbblwEtf+KXYTA0RQMkddSinwIZ?=
 =?us-ascii?Q?IezQEnaaWt3mgxxTKh+w9qCdvnHXEgQsMPxoaBW7uy1JDjxEfRwg/pui4rfg?=
 =?us-ascii?Q?EcmPMwd8QoBcPk0gKpzBrJ9fKnThHsUCRw69NGJn5oEB6sJ80jUO0BBkyDNX?=
 =?us-ascii?Q?onYeg7So9PAOA6d3a86n8ZomEaiRu1x2T56hS+YVeN1MB1A6n9gSC+ieTx2D?=
 =?us-ascii?Q?Noenttl4PekvaEEakP6F0lsfq0lDWaqopIBErfmBvukNS2xMk+uVscIa7pnn?=
 =?us-ascii?Q?6BEWvnWXN6YYPYcQ3igj7SkzcVu608WCELRVRzei1NmFFQf39uzO6CiScRO7?=
 =?us-ascii?Q?Ci0bsjWRSeeROMGYlehc4jf2YnAA9BPrU6AwIxVttjXh5xxnuTgcmB9AyZU3?=
 =?us-ascii?Q?09tvsNlDn1c3rxhb0KWhZD+BT29AnKFHl8tHQ6q5R7jMW/iVkoXNP2UIofzQ?=
 =?us-ascii?Q?N2vYVHGiXS5RSQuubYJaR8Hn5P4T55b9kxaQXaMxB9UCoN9dEHM6UWXu1Hq8?=
 =?us-ascii?Q?alMwkMyHCEqwM1yzvEc1cxq8n3ZGNRtJamcApJhMaVMPBGA3Bt5964nEpGZi?=
 =?us-ascii?Q?wGDx6GlwV0iot55lyM0oe4ik2JwgGta2aHYOWR1TtYA5MMP2BgwIeNCWYS7I?=
 =?us-ascii?Q?eil+FISy98tb3W3xk7QtgxqFNeDnMiOxGBWZ/mwU/l2aCVfO1HwmB+FUpiCO?=
 =?us-ascii?Q?DUWe9TTW6lkRPkTlRDAkS3mzUFDrQ47K2+65ePHaCkted2VfIMeUZNtP9WGu?=
 =?us-ascii?Q?tK1m2OGIY6T4ef+WIvOMrKwWw3iZ+sTx0/V3wRSQ+zbUX0g8l85yDpB8SZ7m?=
 =?us-ascii?Q?uIwBsrMYZBDarls3opC254ZRwn4L6O5rv0B2tUK7XKCwEfMtpYKXa8Icj4cP?=
 =?us-ascii?Q?xRlNfziKwPQyQDa3CNRJ00F76FYprmvcurDj4xb+10jTBBSGQGvJwFWeZ7lH?=
 =?us-ascii?Q?6ppJ07JdvP8ZpfOLWb/PzJFJIHHXHXDDb+5QKUOMejB3hDSG0+RnmoNH3qX6?=
 =?us-ascii?Q?M2NAYf6NBlIs8i4I7/gtHhR6mPzdo7+XEBzJVwiT6lh2gJc8Am0bXS1KyPm/?=
 =?us-ascii?Q?NOx6Yu/x0UN2+jQVBDKFN/5PKvGgCj7S8VfaY/SNgojiwQ/IISZy88Vh4no8?=
 =?us-ascii?Q?TWx/iDUDsqjtKCsnb+e65IQ2bZLpjNGJ9c15zZSXHTI67m1re7gs5ezYrlET?=
 =?us-ascii?Q?L+nuZI8lAGiAkKLiV1Q862UNTlmk1gjGhMsRmQ2oR9pI/0Svwfc6WyJMJYVM?=
 =?us-ascii?Q?XJmjEKz/ycIBLPrEXV53pgZyPobTC+OSCSJniiwAt42UraJIGEWsdIvOhurM?=
 =?us-ascii?Q?KhdO9IqF7F2ZwSRi0BJEjFPJlvMz5B6zF5X1cOwe8RmJGNVitRt8/zZACdQE?=
 =?us-ascii?Q?GlCV5wvdMSFhRTF3uWeZ4wvX3qNEa4lLzEUaM0yWiMClqfZaGmD+8IixK72Q?=
 =?us-ascii?Q?Fpo5U9CKsW76nSoqsf3DaDIliQFqyeK6ZNv655meltWBBwRK9wRWVy5ccvty?=
 =?us-ascii?Q?sNq3awvawXvA8W7qUTdrh8ig1XD2lQ1S9KsytvtifM1B3PtZewUbxcFsXP+e?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8FD080DAC61C14F9D37EA9A026B9834@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33227dfc-a221-44e2-46a8-08dab5e221f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:06:46.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PY+Q6mLDW6Hjw5hV4+PLSWYe2CdLhO7kFU1L4CCSBbrLof4O+gfNNALxWsTdQiFwOzoi2cGV5gyfqbys3iD+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=497 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240104
X-Proofpoint-GUID: 7l3sGLS8Nd1xa9YuUnOoq1NdgqRgDDV4
X-Proofpoint-ORIG-GUID: 7l3sGLS8Nd1xa9YuUnOoq1NdgqRgDDV4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 23, 2022, at 10:07 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Thu, 20 Oct 2022, Chuck Lever III wrote:
>>=20
>>> On Oct 19, 2022, at 7:39 AM, Jeff Layton <jlayton@poochiereds.net> wrot=
e:
>>>=20
>>>> -	fp =3D find_or_add_file(open->op_file, current_fh);
>>>> +	rcu_read_lock();
>>>> +	fp =3D insert_nfs4_file(open->op_file, current_fh);
>>>> +	rcu_read_unlock();
>>>=20
>>> It'd probably be better to push this rcu_read_lock down into
>>> insert_nfs4_file. You don't need to hold it over the actual insertion,
>>> since that requires the state_lock.
>>=20
>> I used this arrangement because:
>>=20
>> insert_nfs4_file() invokes only find_nfs4_file() and the
>> insert_file() helper. Both find_nfs4_file() and the
>> insert_file() helper invoke rhltable_lookup(), which
>> must be called with the RCU read lock held.
>>=20
>> And this is the reason why put_nfs4_file() no longer takes
>> the state_lock: it would take the state_lock first and
>> then the RCU read lock (which is implicitly taken in
>> rhltable_remove()), which results in a lock inversion
>> relative to insert_nfs4_file(), which takes the RCU read
>> lock first, then the state_lock.
>=20
> It doesn't make any sense to talk about lock inversion with
> rcu_read_lock().  It isn't really a lock in any traditional sense in
> that it can never block (which is what cause lock-inversion problems).
> I prefer to think for rcu_read_lock() as taking a reference on some
> global state.
>=20
>>=20
>>=20
>> I'm certainly not an expert, so I'm willing to listen to
>> alternative approaches. Can we rely on only the RCU read
>> lock for exclusion on hash insertion?
>=20
> Probably we can.  I'll read through all the patches now and provide some
> review.

I've been testing a version all weekend that removes the use of
state_lock. I haven't found any issues with it. I'll post what
I have in a moment.


--
Chuck Lever



