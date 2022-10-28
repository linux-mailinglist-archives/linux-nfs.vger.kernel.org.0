Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD31611927
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiJ1RVo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiJ1RVi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 13:21:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397562923
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 10:21:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEiJlb030079;
        Fri, 28 Oct 2022 17:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5+XQhbHTskhex3VhcmuCadQ/c6Pmq1GNVCo3/1C+w7I=;
 b=mYX7yCWvA3yXhg9YFUlAyw+NDzRx1UbqAj/gunFSgDiTV54Nacy6tazFVbU68k4U+i8l
 RQrpMT+VCuLwIV/TYKzxvG3tA9y+QCGa8ydrXRdYq2yXIMwzrUiDybiQuUNZ6kPhP6ro
 4fwTO9VcZUAiNp7jAs4K7+YqjBoTt16lnc3oqP6VPGklQ94txUQeMykr/f+tnFzR5E6W
 BAKlaj8206cIsrCpn8yA/aRcVdKk1QEac82ezh7KV1rctj0rWtOrKbrKeZOnuEK9rafl
 sD1K+F3YINhGWfF/QxhWojb2poIYKtwz8w0qd/IEzc9zC/RxNgzXM8WmUHiretxK7cMd Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv5shr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 17:21:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SGoctN026488;
        Fri, 28 Oct 2022 17:21:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagra9j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 17:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdbuD4Z1mD1ETFFM4kPoImhxuyM4LEreY20YQSka5NeBSd4iDut3deypI/8aA0zV3zWxhJVOcIolhShAw2RnuuYrioBSbZ1YxshyLEe0Q4dHAhqTFja+4WTTXzGIR+aMtaw8Nx2SUqN9ooYATYMQ8l1DYeXo7ppWJvphwDKv9T1pF4fiwSBkihDuVPxEfAPmLGWdQ0tvSJ45jxI3Gt1itWWwY4HGwgdHLKTe+OI3yzjBaFLI3lf8dcnkZuqFOxA/DAfuMtqQMRfEQXj8oISgKaMgLadFFIuB9nl3/pyr+trmPb39t+0sfH3fUH1kYspbabACyE22RzURzBjSPxqSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+XQhbHTskhex3VhcmuCadQ/c6Pmq1GNVCo3/1C+w7I=;
 b=m59/mJ7r6kiCNjPV4TUDrz7126XX5w8/DgBzHgmHBoG4FsyGD6MddpQMPH7wIDeW0XkzzIkY65EVILLdzFTKZ+hYznuUAfGx4SXnmg2avcabcbu+TL4AbO3sA7YyOSheNTi5AqKi0c7Ss/AIyUIPmZ7JzZvRjV0xVDw63iY9H1Y7180osVaNvln5PN19iEdJBLrrkbjxQVldz5ePUqocXjuoo8fcRirYVbucF/1hjeNQg4iy+rGb5HOSwqmmpWW6DrJCLCdkwnJNXQywWUHJfH+WuGGksZUuJmscxmRt28Z/UyDOgF9lTYSPNpy4Ru6hGab8vcJouqkCNCXNYsmAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+XQhbHTskhex3VhcmuCadQ/c6Pmq1GNVCo3/1C+w7I=;
 b=RkVaMutF8t13FZiIm1NXQg9wIBZvX80GRO5B6TcSfhFErOlRl8DyCS6W9z9A8nwRcSAFZUg8CCMeaZ5SaJhB7HsyLrAP4mBNRPVzf2tkV+PcgXvInWDHCXIc6upx2KMEJP1xIz/OqrreTuAPPD0mjlei3XAWZXXeTwqJ1ABMEyw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 17:21:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 17:21:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Topic: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Index: AQHY6k5k3iaHcLvdwUOL1QTSt6QmjK4jykqAgAAebwCAAAbTAIAABgIAgAAZQAA=
Date:   Fri, 28 Oct 2022 17:21:27 +0000
Message-ID: <A040CDCA-5E3F-470F-8D69-8FF9DA4325FE@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
 <20221027215213.138304-4-jlayton@kernel.org>
 <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
 <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
 <65194BBE-F4C7-4CD6-A618-690D1CCE235C@oracle.com>
 <cc4bfa448efedd0017fc7b20b8b7475907acbc5e.camel@kernel.org>
In-Reply-To: <cc4bfa448efedd0017fc7b20b8b7475907acbc5e.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4958:EE_
x-ms-office365-filtering-correlation-id: 921ad7af-2e68-44df-df5f-08dab908d894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dB/J9gXD/1qeu916X1a1iS3hfO1KoX4vdm4VTWrDmf3g3YudjoWulN/B3fvrffAu+kzjhuJXZzJHVdWTP8X/AwMCurx4F+2wJRPBqSMzAYUJJ7Nfo/ejA48i4Jrr6E4C1UszAdkOyxMJRJV4yeMLQUwBjk3RNurz5zY+gNeEBngEPKqoQ1OkagyPfewL3jm1u5BoMb5F4UKNQw1mEk7tjHmuU/4VqyVhN+/NuP/xAzMOzBpzz3oe3m9eHm6xwONbNovyuu5/659Ry9hclmTEDBxm6/RjNN5GpncJn3V1lQ1JI/aVvuyOlltkm/E2nSNNGJwn17psf/eIGn6iT5ewER+RcpytQvBMBW/Y+Xa/Ar2cheXrWyykVID+X137C1Y+T/F1PR3AuyGmGDgEhNLHFgQBSU+xGJYSxLWplJ8hU+c/Mlha4+KD7hkt0l3e+BTj//l63MnzP5gCJlq0t3IgtFLVZlx+aZ4Zfo0fQ2RLvDXQshnRhuCAq6QWjjz3KmSXLZOiAmlqnykQe/cL2FBCDZvbIt7NqZ45A0+TzL164G5u4MExNCE4wVWIJUK/qlAZ9fELPRi0vpar7XKLPvYAfn20WgYOfjWtdPOJLKYp7aXDpd81hSXGxAaixmI/XxTLAbihqdhVKwficwIO4AMHM1WFkd5/TAD6X+N4II2I7FTraB70FD1Sx8mtedyFQNIP2GIGBhNNtqUSWRTgCh+FNUs2oIcxBxiCpd5rgOhSv9WOVaKPqvU0zeGmzYQ60+ViftD312YdybOnbdakIR0nCVhoJqwXoC+ODb9eE83e0Ng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(38100700002)(122000001)(8936002)(6486002)(2906002)(478600001)(4001150100001)(6916009)(71200400001)(33656002)(54906003)(5660300002)(53546011)(86362001)(36756003)(6506007)(26005)(6512007)(76116006)(91956017)(66899015)(83380400001)(2616005)(41300700001)(38070700005)(316002)(66556008)(66476007)(66446008)(66946007)(64756008)(186003)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nmYB+6KA4DZIkIMr/LoBCD5vDod/6gldFPBriV5JbSZgbAm7n/bulHPQCC1/?=
 =?us-ascii?Q?HHebF0yt0lorg6zM3nDgLDbS/P2BfauWK35cHcvos8lomSizmprKZ+wWZ4jQ?=
 =?us-ascii?Q?+qsK/BfQ2JeuQue+nP314oFWPD8xwf7yy8Dl9iv1Walyx63nCYkPa0n349ee?=
 =?us-ascii?Q?jd61fwXhTkTlKABdmOilcmSlOpIJPHvQ651JR5EGpQUUyPF8v/TcbbmI2+/p?=
 =?us-ascii?Q?Hea2aw45yUWeOWb390A2FUo9ox0R7IIZAeTZJYcdSZcguy0Fj6i7Q7jyGfOK?=
 =?us-ascii?Q?XKeUTQCO0Bhz8voW+f0PlSUjxy0DMiKyVuNon1JU6Dbl1E2qGv0HPs3ug2QU?=
 =?us-ascii?Q?N2hDIZ2b0xPYVPHaI0k24TRrkRU8ctpswM5ckvqM1EJRvdnyGZOuOiwRCVqR?=
 =?us-ascii?Q?7W6jRibD0Ef64TKB578PLMSrwfBWenqq40rYx6BSSfCnlhn+YeQu5/eQK80k?=
 =?us-ascii?Q?CM/FIzVpL1AtuCPqLAOWqbI7S2tf0tFgj50YWfxZJQq5Hsc792tCvmsnBM1z?=
 =?us-ascii?Q?oDWr73jinnd2JlHDNAY42kPy8+a01f85ne/KnfNmktqy4FPXV0NBOm3rdoRI?=
 =?us-ascii?Q?dVTV2W1BjthALS2sMJ7eZUQbmTbQKQjWvUDuBIpTnruZRan8wfRnkmuWCMUH?=
 =?us-ascii?Q?yHDzog2IUQWklPH+DXWmUQ0BDtkrnqz3FBgr0WX8Wk5igAbgc/Y478u7Wz3A?=
 =?us-ascii?Q?nBR1QgoD/kpRUSClIhaH84z3aAMOoW3btvSCi02pvSMiaOJm1ZP3TWZk8PcC?=
 =?us-ascii?Q?lJCKQJ205AIo5C59Ep2bSAp5Y2AanSGKfQQoFASYOxE3PN7It1fbeWjtTkKT?=
 =?us-ascii?Q?/kPxi4L4xdLqPalUSIwIj19CJtPengSstFKQINbl2BRKwvezIGiBk4u39PXz?=
 =?us-ascii?Q?VTRYv5zbevWHZYSsaCGXAWd6wya7fwnDphNBrmamyMAaqfp30Lo0mxgcUWXf?=
 =?us-ascii?Q?Er//3IgNu/cbGLh7cQ3ayT5EchM3uctGy6KKtW3GBOMXVORCSjR88wtxALas?=
 =?us-ascii?Q?KqzCew85Sd4y2eRRQyY5dSJ7P+YqrX76mgBUmqvmrUPK9qDEjCLE4mBz6eXe?=
 =?us-ascii?Q?nT7yeBphZ6hIdjp5wy0vIfZ2i+JI6mXHZzL/lej8lg93MbM2RejqeWVFeLbN?=
 =?us-ascii?Q?ZHszUg92O/BEei1azinhtTa0qPNoeMx/ODIUGkPP0xqp+5V732h7YRRJh5j8?=
 =?us-ascii?Q?zHkPJ9gjlUc16KNbkNO+dX/t8VcCWhv0//ioBIrZhZwB/hXE6BFvU4QcJsWS?=
 =?us-ascii?Q?zAdnuDkUUVCiq4E0a1zyJyD09wYFMKD+IJG/nqyOvGW3S1uEDu1bDi5riQOr?=
 =?us-ascii?Q?1O9yGKs2DWLFycyXFlPTmJ4C1VYXQIEIQqYPxf808LAUPlg5V4OIVfQgf6AG?=
 =?us-ascii?Q?jIr2wO8J+y1h0Yw4gUv3BziPphWXJeFy32ucdVNdn6eAAM/k/XxZGHek+s7y?=
 =?us-ascii?Q?GBUYKhevK7R/Yg6hiADX3/uP/Z6O/J72rm06l8xQ4MBHDdVvv9W2NtEZ++L4?=
 =?us-ascii?Q?ZmHk3J1j4K9LFbiFvYIBPC1UuYmSgXdvLF3gG7RzWMbpqXnEVXeZ4LlhVA9w?=
 =?us-ascii?Q?vouwtkAt4euXvPn3Ml26pwn4y04GU7y1otKKjjc4fSp6xPkMznbKkvc/7Q67?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E113EFAE5CDEE046AC1C649D958D83A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921ad7af-2e68-44df-df5f-08dab908d894
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 17:21:27.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbC9QChSr9gSK94oZLGlkhqbUGrqIuVVVZDNPBaFP2qIcUT7kRAXZwxwd1t+3JZApFAr1vHEX9VADm4jcnqOjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280108
X-Proofpoint-ORIG-GUID: QYAmMBM10gyjU7OfhtJtT7E-24r_6oZP
X-Proofpoint-GUID: QYAmMBM10gyjU7OfhtJtT7E-24r_6oZP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 11:51 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-10-28 at 15:29 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 28, 2022, at 11:05 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Fri, 2022-10-28 at 13:16 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Oct 27, 2022, at 5:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
>>>>> so that we can be ready to close it out when the time comes.
>>>>=20
>>>> For a large file, a background flush still has to walk the file's
>>>> pages to see if they are dirty, and that consumes time, CPU, and
>>>> memory bandwidth. We're talking hundreds of microseconds for a
>>>> large file.
>>>>=20
>>>> Then the final flush does all that again.
>>>>=20
>>>> Basically, two (or more!) passes through the file for exactly the
>>>> same amount of work. Is there any measured improvement in latency
>>>> or throughput?
>>>>=20
>>>> And then... for a GC file, no-one is waiting on data persistence
>>>> during nfsd_file_put() so I'm not sure what is gained by taking
>>>> control of the flushing process away from the underlying filesystem.
>>>>=20
>>>>=20
>>>> Remind me why the filecache is flushing? Shouldn't NFSD rely on
>>>> COMMIT operations for that? (It's not obvious reading the code,
>>>> maybe there should be a documenting comment somewhere that
>>>> explains this arrangement).
>>>>=20
>>>=20
>>>=20
>>> Fair point. I was trying to replicate the behaviors introduced in these
>>> patches:
>>>=20
>>> b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()
>>> 6b8a94332ee4 nfsd: Fix a write performance regression
>>>=20
>>> AFAICT, the fsync is there to catch writeback errors so that we can
>>> reset the write verifiers (AFAICT). The rationale for that is described
>>> here:
>>>=20
>>> 055b24a8f230 nfsd: Don't garbage collect files that might contain write=
 errors
>>=20
>> Yes, I've been confused about this since then :-)
>>=20
>> So, the patch description says:
>>=20
>>    If a file may contain unstable writes that can error out, then we wan=
t
>>    to avoid garbage collecting the struct nfsd_file that may be
>>    tracking those errors.
>>=20
>> That doesn't explain why that's a problem, it just says what we plan to
>> do about it.
>>=20
>>=20
>>> The problem with not calling vfs_fsync is that we might miss writeback
>>> errors. The nfsd_file could get reaped before a v3 COMMIT ever comes in=
.
>>> nfsd would eventually reopen the file but it could miss seeing the erro=
r
>>> if it got opened locally in the interim.
>>=20
>> That helps. So we're surfacing writeback errors for local writers?
>>=20
>=20
> Well for non-v3 writers anyway. I suppose you could hit the same
> scenario with a mixed v3 and v4 workload if you were unlucky enough, or
> mixed v3 and ksmbd workload, etc...
>=20
>> I guess I would like this flushing to interfere as little as possible
>> with the server's happy zone, since it's not something clients need to
>> wait for, and an error is exceptionally rare.
>>=20
>> But also, we can't let writeback errors hold onto a bunch of memory
>> indefinitely. How much nfsd_file and page cache memory might be be
>> pinned by a writeback error, and for how long?
>>=20
>=20
> You mean if we were to stop trying to fsync out when closing? We don't
> keep files in the cache indefinitely, even if they have writeback
> errors.
>=20
> In general, the kernel attempts to write things out, and if it fails it
> sets a writeback error in the mapping and marks the pages clean. So if
> we're talking about files that are no longer being used (since they're
> being GC'ed), we only block reaping them for as long as writeback is in
> progress.
>=20
> Once writeback ends and it's eligible for reaping, we'll call vfs_fsync
> a final time, grab the error and reset the write verifier when it's
> non-zero.
>=20
> If we stop doing fsyncs, then that model sort of breaks down. I'm not
> clear on what you'd like to do instead.

I'm not clear either. I think I just have some hand-wavy requirements.

I think keeping the flushes in the nfsd threads and away from single-
threaded garbage collection makes sense. Keep I/O in nfsd context, not
in the filecache garbage collector. I'm not sure that's guaranteed
if the garbage collection thread does an nfsd_file_put() that flushes.

And, we need to ensure that an nfsd_file isn't pinned forever -- the
flush has to make forward progress so that the nfsd_file is eventually
released. Otherwise, writeback errors become a DoS vector.

But, back to the topic of this patch: my own experiments with background
syncing showed that it introduces significant overhead and it wasn't
really worth the trouble. Basically, on intensive workloads, the garbage
collector must not stall or live-lock because it's walking through
millions of pages trying to figure out which ones are dirty.


>>> I'm not sure we need to worry about that so much for v4 though. Maybe w=
e
>>> should just do this for GC files?
>>=20
>> I'm not caffeinated yet. Why is it not a problem for v4? Is it because
>> an open or delegation stateid will prevent the nfsd_file from going
>> away?
>>=20
>=20
>=20
> Yeah, more or less.
>=20
> I think that for a error to be lost with v4, it would require the client
> to have an application access pattern that would expose it to that
> possibility on a local filesystem as well. I don't think we have any
> obligation to do more there.
>=20
> Maybe that's a false assumption though.
>=20
>> Sorry for the noise. It's all a little subtle.
>>=20
>=20
> Very subtle. The more we can get this fleshed out into comments the
> better, so I welcome the questions.
>=20
>>=20
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>> fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
>>>>> 1 file changed, 31 insertions(+), 6 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>> index d2bbded805d4..491d3d9a1870 100644
>>>>> --- a/fs/nfsd/filecache.c
>>>>> +++ b/fs/nfsd/filecache.c
>>>>> @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key,=
 unsigned int may)
>>>>> }
>>>>>=20
>>>>> static void
>>>>> -nfsd_file_flush(struct nfsd_file *nf)
>>>>> +nfsd_file_fsync(struct nfsd_file *nf)
>>>>> {
>>>>> 	struct file *file =3D nf->nf_file;
>>>>>=20
>>>>> @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
>>>>> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>>>> }
>>>>>=20
>>>>> +static void
>>>>> +nfsd_file_flush(struct nfsd_file *nf)
>>>>> +{
>>>>> +	struct file *file =3D nf->nf_file;
>>>>> +	unsigned long nrpages;
>>>>> +
>>>>> +	if (!file || !(file->f_mode & FMODE_WRITE))
>>>>> +		return;
>>>>> +
>>>>> +	nrpages =3D file->f_mapping->nrpages;
>>>>> +	if (nrpages) {
>>>>> +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
>>>>> +		filemap_flush(file->f_mapping);
>>>>> +	}
>>>>> +}
>>>>> +
>>>>> static void
>>>>> nfsd_file_free(struct nfsd_file *nf)
>>>>> {
>>>>> @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
>>>>> 	this_cpu_inc(nfsd_file_releases);
>>>>> 	this_cpu_add(nfsd_file_total_age, age);
>>>>>=20
>>>>> -	nfsd_file_flush(nf);
>>>>> +	nfsd_file_fsync(nf);
>>>>>=20
>>>>> 	if (nf->nf_mark)
>>>>> 		nfsd_file_mark_put(nf->nf_mark);
>>>>> @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
>>>>>=20
>>>>> 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>>>>> 		/*
>>>>> -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
>>>>> -		 * it to the LRU. If the add to the LRU fails, just put it as
>>>>> -		 * usual.
>>>>> +		 * If this is the last reference (nf_ref =3D=3D 1), then try
>>>>> +		 * to transfer it to the LRU.
>>>>> +		 */
>>>>> +		if (refcount_dec_not_one(&nf->nf_ref))
>>>>> +			return;
>>>>> +
>>>>> +		/*
>>>>> +		 * If the add to the list succeeds, try to kick off SYNC_NONE
>>>>> +		 * writeback. If the add fails, then just fall through to
>>>>> +		 * decrement as usual.
>>>>=20
>>>> These comments simply repeat what the code does, so they seem
>>>> redundant to me. Could they instead explain why?
>>>>=20
>>>>=20
>>>>> 		 */
>>>>> -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
>>>>> +		if (nfsd_file_lru_add(nf)) {
>>>>> +			nfsd_file_flush(nf);
>>>>> 			return;
>>>>> +		}
>>>>> 	}
>>>>> 	__nfsd_file_put(nf);
>>>>> }
>>>>> --=20
>>>>> 2.37.3
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



