Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09665F132E
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiI3UGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiI3UGY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 16:06:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C647016EA98
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 13:06:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UJxkLo009335;
        Fri, 30 Sep 2022 20:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1asMroseGzsyOFeaImYQTNieSlKtP2nuIJGzp3+JOdI=;
 b=fB57egvsk/T5Rk996q/I+5mCTWHrBBdxY1a6KHHvmx1oUsNcmPmNg7btT2FhZ/oUWS5I
 6rv9G2INg2JEDV81vkDFu/Q8L+zboZitFvJG/D0c0FCJSdp0g3Gx5AXHPyUDKOo5nYjU
 g9q/Lmcsbat+ARpNlIGIDcnOmaw8AOuf9CvYNqPhobANc3VsZj2MsUgexYd6stSTz+9Q
 D7kBzZNwqcg6tV/kWqjbapjwgZhD1DdlwaHD8omhCVWrVivXS0xIXMBnOdPornn7M0Wp
 0GfCiYs0VDhkvlbY98SvkhZ+/Hz2O8T41PKyBZwrzipVTAaIedku0IwUs2oauG4uhbA7 Pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwrrht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 20:06:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UJi0O3002602;
        Fri, 30 Sep 2022 20:06:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpry8sbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 20:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIwDgHTjgTbVlWZXVDKXaFlSqY5yaonSR2xDA3buvBFHp8bZsJNwSTvQc9i1DCgYZJcnJ1ffU6sLZOyt3t0mfgOnp0YwiTYTannv/pjSEaEQVKraLCdFgj5pNUxw4B0EUJVNR9Fzvcxp59iQ/8tIRdwOT6NHM8py37dT47kxA0hgGspX0Q+ZsBQH8z8cloUGg5hVy9MaIQeJh4+IY8D//ZtxDQhvknE+S4R/n/dcqklVLLh+d0kO8N1VqIsET96Oj8lQyqQa9pOl4wTUV9FJxGK9C0sZNnxYBjDWVw78V7Jhxr37D9bjGDTB9kCVCv2sqfc/DS6BfWRVsaApTRISRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1asMroseGzsyOFeaImYQTNieSlKtP2nuIJGzp3+JOdI=;
 b=BLWRXUICqb4nR8ArX+99SrT4hu5Y5PTzDHWrxGGPfFV9sQ4yvp9sK3cgPGk+Kq+CCzkwJKeQcMc7z/QVGv5Tr0naseFT3qz/GvntuvJ4B2APnFPu93UBoVbdvtLObRftKsPcHPIVzl99jMZoRcc+2bov/ijmKXGme271jU9WFtQrBf7ugW5mPUTvfG0AL+5C3PhuIkXsCvU69CgUZFu/qovUZwmi8sluDNmbazNtwvDKyETV4DjywVV7gLz95bArDCnjyxChBaib/i7L1QclhaLkBHelQgU8WzBe+w55mw5fe/gFwXji/JGwqDx+DpvUTL3uEVCLKNQdzqQK5kHkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1asMroseGzsyOFeaImYQTNieSlKtP2nuIJGzp3+JOdI=;
 b=lxlvKaNSee2c2GbrIC2sIW/fdD3DW6Ro4ABP+n0kfTIai7o+38+SoQ2sskthdYhWGBvBMzBZf6bhcYeAWx/GC/jNXsdu9OaX8RBkwQs4Nm0hSDRLK7UBqDJUaRjqN2M2cU0Kmn+AdCO07r5Cfr1veH9NittuoeC4GfkBNq8nG/E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5310.namprd10.prod.outlook.com (2603:10b6:5:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 20:06:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 20:06:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Topic: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Index: AQHY1QEWqnYiB4uxs0SMdlnrLaX8o634WYIAgAADb4CAAAkqgA==
Date:   Fri, 30 Sep 2022 20:06:00 +0000
Message-ID: <A5B0F720-D982-4AA0-AE6C-AE0CA8CF1B3C@oracle.com>
References: <20220930191550.172087-1-jlayton@kernel.org>
 <20220930191550.172087-2-jlayton@kernel.org>
 <9D4FA4C1-2246-4CAE-BB8A-D152603E3A56@oracle.com>
 <74afc012abb06df6d0648222cb4c01d22c40942f.camel@kernel.org>
In-Reply-To: <74afc012abb06df6d0648222cb4c01d22c40942f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5310:EE_
x-ms-office365-filtering-correlation-id: 70116a9c-567d-491d-f288-08daa31f324c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XdOg08biDQFdpzPpSigLvOitGkBB/wHG6idtQYSJouTzrFVfKw0NKFP2qp22Po7fnIo/e+BDxt2o/9uc/PasUGPhtev2907M8UvH+x5hvtilWswc3RT5yetGqZe2p/SMwwOZ5isN962wYRpZKM05AxZyRMCOwCyenX5RWUJgDXtb5dCJ9wRMcLJ2X0jIngDlxU+yC/Kvo66ZA99wGSjIvrmEGenJYxpeBDXo2rVc4zTPTOf/AhU6QZp1tQBSmIBZVOLvDjXPumfWdYdoujGWugyqKQXZJY00wv3VOL6Fa6ElgtEz0QHEHCundpfkaCnzE1CVKC9M8CjdNzyCI8SF9h4YWmSKv2QzpeWbWlaj6MBBbMKXs2C6Znt6FjdOtfyHlVorb5U9qPhvBFlucjq9sNbttXipn1A6uCN2VRQWzrOoiKr3/oLIO5Yr+5fUw2Nu0nGnAQA+0v6O0qleKcK8LUKL6Ry5nQib/yrfHkO5mru2aCRY0PkCa4IXGGgfLpwTPicme/yv4nq0l8xpQS9/I1GBP1EuRBNKyEwDlofBjwZ1IwdCcpd44BxKs/Qnxl3zqInCQf3HfZXfJXrG3fB/XQ+GfW1sN4h2r0Gp7+AeDIupvt2DJcyK3H7WxBp1QO0zmJxpCYD/enFyILhihcZ3Bw6DaPjpf6QYISwn5xs/WxhLuMA8hniDDkwK9Rr10M3VUdaC2MgZ2lBu/d8jAcFI9JNV4GbOIX86Nr9SpvETxRrXXkIootJTGRCtlfOSoSbbIzo/CHy9B8kDgtPeNy9PxGcXKuHyYoOyNsF4N2c7+lw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(6916009)(316002)(478600001)(91956017)(71200400001)(66556008)(76116006)(66946007)(66476007)(6486002)(64756008)(8676002)(4326008)(66446008)(5660300002)(86362001)(6512007)(53546011)(6506007)(38100700002)(26005)(186003)(36756003)(2616005)(2906002)(41300700001)(122000001)(38070700005)(8936002)(33656002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rF1XtSHdApYUU0X95IfeboSmDxK+tqXMJSaVYeXHEnHM13j65NfEH0HxmWaz?=
 =?us-ascii?Q?Q8TQnJGSzYB++KXS94X8PTAIdsh2Rv+TWhW0M7ddE397eDKOoCs6mf6UXE+b?=
 =?us-ascii?Q?fiNp4rpW6Ee5VGcljLf6tcdDQ5SpiVc0lFHxSuoD9i2+jQft/3Ezk5bh52pg?=
 =?us-ascii?Q?YlLz1HmFggVdIG/5SbgRJPm5zfgWVSiH9SuyT7xRfjjFS5JG7PbeJ8zM/jjY?=
 =?us-ascii?Q?2kw7wKEn3LkFZHDEENaN81CMSnzwW2dshMOamImjEFxgWCeAGHiW+JeX8ZjI?=
 =?us-ascii?Q?1Zv7ttQXFg0rVHVviJtQRyg2BFZCrRuse5cI06FsnRUUK/OyPbaXtzWq/H1X?=
 =?us-ascii?Q?ft1gcd7DT8NtXTNvlML44Z4wSn7UWsjlejn+AqoibayqiKOEN9zEPyNqCC/p?=
 =?us-ascii?Q?pLZuXLalu33Uw5yp7ppB9O70tJAdYVpRL3iCvRNtupjiW/UkHCJMB9NFkPbW?=
 =?us-ascii?Q?QdOXAB18x647X9V95kESrI4HcfqgNNpDDU3RPAzYpuiRADq3NcKvDiVCM+VB?=
 =?us-ascii?Q?yKzvxLy/CkpSkVVo5oPNn5whulYuqFX29hWatSk0ABaav8+dVbyf9lBhTKRn?=
 =?us-ascii?Q?HkkvDq9ekSmFn+1XDaDhwjEim1GY4WsW5/UBkpfiKeg5XXse1J+f/4qdsEtZ?=
 =?us-ascii?Q?+E+6FEYv+d2QtSA2Kbt9tnR5gaCEBkpX6gD6zMypXpY42JWX6vbnBi09p+Jt?=
 =?us-ascii?Q?qL8BPmDN9b2XdsjYlodoZb0XY1IAI0+PaWT9REzohPT6zE05OIVIqGIrbDyM?=
 =?us-ascii?Q?cfy4GDBHJDiYccR1RvR8tdqKz/zWDSLSsnfhvTqGUZMk0xXJm65f0tJS4YRi?=
 =?us-ascii?Q?O+Y7q+p+/ELvoiRe5rFBX7yYqBuTK7oFm6CxdyqlPGTcVpGCZh+bVPXA5eci?=
 =?us-ascii?Q?Il3CtabWMHwsHILUgd79ogZslFFZorvX0l+fQ8ybO2CgxS4t3RPDNsiq6oDE?=
 =?us-ascii?Q?MhtfXRWv1F4bExIZ73bPQmcVuJMpTYX79EQa5z3ZW9a2yn6Qprg8ETNjlu9q?=
 =?us-ascii?Q?Nk2RSBKC94WF+Ya9SaawhiZEM1SfXzSYl72Q8xpJjpbBKM4p24vqBZ/drsug?=
 =?us-ascii?Q?3Lnp3Y6H6W+bHi7BRFGnyg6WFQY81xTgB4RcNK5zu05BCshztKkTsvuR2vkn?=
 =?us-ascii?Q?IXPwg4LktmT3NHDVaLoMpSB3W/jYY+fC+utrlq4sDoDFpqZgZd9XtYpZhffl?=
 =?us-ascii?Q?eRPk/lBY/2BcwO1Itn5JQDmymXUpwW3fyiBIcYtjCIWYUz0oRPZCaJiLu42H?=
 =?us-ascii?Q?fShb0NOKbVcWbIFKzyI8CW+R1PEJnqjazEW2G9aL/b9yTkncX1NKSrzuSdOq?=
 =?us-ascii?Q?STnptglRC68Tn3zxQaR3TIgtOYmMt5pj2UbhUitx/ykW0+ZCwqFZmrdbDm7H?=
 =?us-ascii?Q?70Ad+1iA8xBxDH6FMBVFh9qOx6pQKJOwp77e3W5vDB10UUEnlbxYYwGthbz+?=
 =?us-ascii?Q?zRYpLShgYFdH/cNAw65qHkVpViMyjJrEOqmWneB1VXFxt3XlfBa7zXPBscrz?=
 =?us-ascii?Q?2dxsaQ2LW18y/gLOMqfbdkY8jI1C6ZRQWVa1PfaaQKO3CwTPBFExmhEX87uE?=
 =?us-ascii?Q?HLQZev4iR/nC+D3eyfyUkuVd87nMG4z/UE/9msYqkFEV2wzwa9tEfKE3g11P?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5862335CE4E6744E9054FAEC07F514E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70116a9c-567d-491d-f288-08daa31f324c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 20:06:00.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YosJUSAXXh+WouyP4rQVsACgmTLjZHqC25PgPzdOLZ5nXNZhECevbW1NZBWSnVR2Y+PEQqE8CBYScNpUDCKYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300126
X-Proofpoint-ORIG-GUID: CKFpG_tu-uCRK3mO7LP2pvtRkc2kWQ2d
X-Proofpoint-GUID: CKFpG_tu-uCRK3mO7LP2pvtRkc2kWQ2d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 30, 2022, at 3:33 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-09-30 at 19:20 +0000, Chuck Lever III wrote:
>>=20
>>> On Sep 30, 2022, at 3:15 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> nfsd_file is RCU-freed, so it's possible that one could be found that's
>>> in the process of being freed and the memory recycled. Ensure we hold
>>> the rcu_read_lock while attempting to get a reference on the object.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> IIUC, the rcu_read_lock() is held when nfsd_file_obj_cmpfn() is
>> invoked. So, couldn't we just call nfsd_file_get() on @nf in
>> there if it returns a match?
>>=20
>>=20
>=20
> Adding side effects to the comparison function seems kind of gross.
> Do you know for sure that it will only be called once when you do a searc=
h?

Yes, when a match occurs, the chain walk stops.


> Also, there are other places where we search the hashtable but don't
> take references. We could just make those places put the reference, but
> that gets messy.

nfsd_file_do_acquire() is the only place that calls the comparator
with NFSD_FILE_KEY_FULL.

 165                 if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0=
)
 166                         return 1;
+                    nfsd_file_get(nf);
 167                 break;


> I think this is cleaner.

Unfortunately, the comparator's second parameter is a const
void *, so we can't modify the matching nf. Ho-hum.


>>> ---
>>> fs/nfsd/filecache.c | 9 ++++++++-
>>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index d5c57360b418..6237715bd23e 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>>>=20
>>> retry:
>>> 	/* Avoid allocation if the item is already in cache */
>>> +	rcu_read_lock();
>>> 	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
>>> 				    nfsd_file_rhash_params);

This probably should be changed to rhashtable_lookup() so that
we're not double-wrapping the call with rcu_read_lock/unlock.


>>> 	if (nf)
>>> 		nf =3D nfsd_file_get(nf);
>>> +	rcu_read_unlock();
>>> 	if (nf)
>>> 		goto wait_for_construction;
>>>=20
>>> @@ -1090,16 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>>> 		goto out_status;
>>> 	}
>>>=20
>>> +	rcu_read_lock();
>>> 	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
>>> 					      &key, &new->nf_rhash,
>>> 					      nfsd_file_rhash_params);
>>> 	if (!nf) {
>>> +		rcu_read_unlock();
>>> 		nf =3D new;
>>> 		goto open_file;
>>> 	}
>>> -	if (IS_ERR(nf))
>>> +	if (IS_ERR(nf)) {
>>> +		rcu_read_unlock();
>>> 		goto insert_err;
>>> +	}
>>> 	nf =3D nfsd_file_get(nf);
>>> +	rcu_read_unlock();

What might be nicer is if this used rhashtable_lookup_insert_key()
instead, and if it returns EEXIST, it simply frees @new and retries
the first lookup.


>>> 	if (nf =3D=3D NULL) {
>>> 		nf =3D new;
>>> 		goto open_file;
>>> --=20
>>> 2.37.3
>>>=20
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



