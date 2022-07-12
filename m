Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276B9571C36
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 16:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiGLOTE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiGLOSP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 10:18:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CAFB8E82
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 07:18:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtUMm022324;
        Tue, 12 Jul 2022 14:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2dlAX9Rupdy1DB70ypqk0J+PXrcJ3/wkGb0p+79+O5s=;
 b=MJ+kPKrzG+d09AUSdEVr0W0Jmr7u/SbwmI7JcTl6szUAXuqcM6ZTrLJa7cP56JaEuTV4
 QdG2gxt68VAW/WJqvH/FpXs+yHRzlHNkIuc8sr67OIfrRBiF/66AQqQOhd3+DrWfC/OP
 yMd6CXA60O7dU5e0qJRCr989xzW1r7beaHixrO9BWIpegRulnLV9yPBphdDEsAvYh5TQ
 Hhv1B+t6CdRHpOFroTIKqYyArl9SWDygp7Awqc+GAA235cr0tqduNyBLoHGT2wOsWHUS
 RCxZ574DnpFilZSUPL+nD0wBWDbZqbaZWuWCvAAGHjkznoHb8EfvDjuqUFL+QpBpA8l/ sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sf1vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:18:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEGbnH002266;
        Tue, 12 Jul 2022 14:18:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70431wbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeOhyfhh5eEct0hX7ek+4VlCkKny2m9mq0wjY0pETRk8Okao/8RB1KF15+8a/2VN3lKEreGaHMa/xF9PuIh4FJ9PUz0szsjbTSu+WZqTV/MoLjvrGBzhK3bt08a393nmR8LVoGjzVIjoTwFw3zjb2sDsjKDPeNMtENTIjB3YPnG3PSi0AUNmM5bMrBjoalIAdJXG6Ap74JP15IbOL5nNkQoLOpKmUAWRGMtpIhEpLbGYPupepLLPBfsogU97WkieFt6YoIkhMhLMDRpEZtnRmldVgAjSeIlvQYczsxinl3iR30nk8KBwinkZhBQriqrNqAF0XNMS2ZnT86DAP2vk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dlAX9Rupdy1DB70ypqk0J+PXrcJ3/wkGb0p+79+O5s=;
 b=bm0mSFEEebtDP27mFnDhyYMiyRKJA/PoUAzIsHTz7/y5yvjwvPCnH+MIHxVJe8qmGG5AztPiXLNrvdRK6xewe1VYEuzqoZ4nIMEP+lgmIG8MzUcnYiBYUhvxdWgl+Yh8xLkGeDfw9Uq/+PXPkujDL8DO3rvQACIwFgd2RgkiwV3DdnvoNm/kgFI/8E2v+52/8hO/g9jpqrvY1EtqRpz71ZAO9ureAxXx7iQWyAzEZC+6Nl+u3DsE3+tMa0l3AS4Wyc3LZLvx9s64x+aVcUGdOH9sRgO3LiskKkL7T/PEtXRJTSRUp/+jp5kYvVmay4Vlo3GfjfDMVBllTfzFsDMCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dlAX9Rupdy1DB70ypqk0J+PXrcJ3/wkGb0p+79+O5s=;
 b=ihjHzIV24cL1M6AOM1tXSDZhjdA+ZBLD6yJl5v4iqijYNjxo1sdB9fpgGhX1SoqIjguS1MN1k5gwQ7eJD2m+T1PBCDKVm7E88D8osmjecSlYlUjGLdJPOogi+IBTvzjt6wWAy7zUzLyxWazv9P5tKMwxteNsS3uJNnFnmU0ntaE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3458.namprd10.prod.outlook.com (2603:10b6:408:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 14:17:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:17:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
Thread-Topic: [PATCH 0/8] NFSD: clean up locking.
Thread-Index: AQHYkO+nUhzdndZueEy9RTo7pT1nKa1xiSYAgAiEbACAAMTsgA==
Date:   Tue, 12 Jul 2022 14:17:58 +0000
Message-ID: <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
 <165759318889.25184.8939985512802350340@noble.neil.brown.name>
In-Reply-To: <165759318889.25184.8939985512802350340@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f493b13f-c4f9-4a55-7ce9-08da6411521a
x-ms-traffictypediagnostic: BN8PR10MB3458:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ulsddQD+PvAdAC2IkQUv82UpBwSZCUuHcDoJyWaSLWVz5DPpeozIL6LqX667vYhxjbk0efTV80CW+nFIykDvuyB9BM8losrZ8HdgW9Jli2B2EZQY1v7FzSfSUHMBB78wCMIxM6URyYV8aU+2weW0svnGPNymh+zUgEruVc2grMT5PXIhS9+MOduGpdLSvmOdUroNWxv/T+htzkRu76LgMGbvOzuN8Ong04mm6x5+NXU8mcuyaAhEO7/sBOlbUJATKrlF/NAWoYJNUEF/0Q/O5qSHiXG1ThKo/GMzer5CzJ7xpRNDwqoDcOwZdUM9NtLvD4R+QkuNil/lLXSA2vFazamHyQD7zlgHXVEs+i3nujYxKzyT3Ay/B59G+QZuSGXugGp89CWYPkzw4DpdXA4sIYmMsoCFIqISx9taCaLqct4P5Hflkm4TmpxpvSUoC+OtQTtVvP7vaZ9BsoW7HtxRuhFbs+P69i5HbTdDl/oVUu385ZWj5wflhDCQ/tgYHlq2G2om/NFjkq97UIrgIFVCvxQpHS3+bLARQBqtKJlMFpfUyw685jzPuvQodu+zFg3tDJXdpeerXmw0GkKHAt68hdwUcpckE6zkHIcKy4K6eumDtYlszBFEme5A5Mj/tdC+PTmU23VCakQLamBaXDST9nfBloAkJuHTeei0b3JmPYetwzCwgQ8SPcBA4B0FgtzTJMcvaCFI+fSoPXSeoFUbzolfTQN6zWeGTMsoPKZzP6c4ky5HkLupsTs80ZX5tZnDBBVKSeqRlb+MtzaLiLrmhNaB8CbhDJ9HX3kWva16IycUI0uduUTODiSVPt8C+pOJS+gJX0+o4gy8cQDqkOTxPkHMGUgD/odCmU3tD9PRNjw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(39860400002)(396003)(91956017)(316002)(86362001)(6506007)(26005)(2906002)(478600001)(8936002)(41300700001)(6916009)(2616005)(53546011)(33656002)(6486002)(5660300002)(38070700005)(6512007)(76116006)(38100700002)(83380400001)(122000001)(64756008)(66476007)(4326008)(66446008)(8676002)(71200400001)(66556008)(66946007)(54906003)(36756003)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ElTspOfyGy9YBpv3+Uz2FwtAAbrOuYIJeHS93pmHLUWLfesGxfhR8YZRJioI?=
 =?us-ascii?Q?TGGLNpTlHARuwVZKDLbCmZlNs9lcUur0TrTlAlglFuAwycUjiWl5n3QqG2AJ?=
 =?us-ascii?Q?YDSjV1uHIZjFHfid1r27II2srEmbWgd//98spG2F0Xe/ZJ3qP6V3O/DXZhfR?=
 =?us-ascii?Q?MX4/2Bx9XKW1So5u5HhKEm6QFepNtW84x3hXN1X2Ri03FNH1D8+PG7ptxz8P?=
 =?us-ascii?Q?gXNmYnQUaMfAaFR6bUagj5/Sl0vU6nTMYTkf1AJvUUSwdfYrb5ForooTLAy6?=
 =?us-ascii?Q?1Nibs3P3Ulv734lBmJLU5hIahJL5NKHy2pAAwBIS/0QkG1p6taU8aElQTksV?=
 =?us-ascii?Q?gv9pKKdNCYs6xC0H51sEqQmmCA0jv8SulTDHVgVnAd3JafXz/B2/c4pNpGwH?=
 =?us-ascii?Q?CbPDWe7W696jK5GlUAGEPqYeCIyfVm3f7dhcoYR44BKd4/RNE9Kp71bXgHd9?=
 =?us-ascii?Q?H3K4N/fHSCdNC+UA99qCJVq63vFgp49KZqLuA392zCUnktO+AC7bgOK3rMiA?=
 =?us-ascii?Q?Yy7ZDuTFbNbdyKvoiDzuKQFrzJiUKABdOd0f2ViUq4EaqCPqPrOxdlFl2H2T?=
 =?us-ascii?Q?dMrIZ2Ptnx1kfMMjaipIQgG66hNjQBUSJqKyh2Zvmk4l91TV2QtplXnzrbho?=
 =?us-ascii?Q?BSRobBCKYsvkKVfl3TsDIx8cvSgcBoTZMR25T/3JMws8NVEmZQf4VGkasaMm?=
 =?us-ascii?Q?f3/hXJDUBAdUjMrcxN6IMjVF1E4jV5bnw5WlaOfTVhsZ4hw6rkqEwiZSjcgg?=
 =?us-ascii?Q?G+WQCiBGFk83bRIHd9H7E+4DqYInYlMVPCfskpXk3ESW4JGvz+TgEge72hjJ?=
 =?us-ascii?Q?6V++NIWf4KXvMDYOE67X0klPmSWFnXsHlNOmLeI0a2SBLiGzeGPE2JUV3WaS?=
 =?us-ascii?Q?M4SMeT1ZtTD+7KmH+DbXtV3Gk6yjeNI6Umr7L4LhqPyQSqnubhRQVKtJaWoj?=
 =?us-ascii?Q?lETAm4E9tqzR4NWWnfpqmBZEiBll34sKe3+tnofLyXaWAtA3e02+VjcnDsUq?=
 =?us-ascii?Q?41vVEDNQutJouU29VQ2lNRoRcx9uX/l3uNlZy5art8g8p1bJOzo7JvLT3u+p?=
 =?us-ascii?Q?mBfI/lymhVW2M+Ho9cdu8Q9l3cWHDfkSNFYdx+NmqK5zeZLNOLJns+BKKw+t?=
 =?us-ascii?Q?kCWJtLCfwl6ztr53M4y0kLTGsF8gPTmNXbbSHt5oVsvWmD1QqZv0pLAgNXLX?=
 =?us-ascii?Q?iR0zjeN42HgKS6wjCGQoSFA6IaC37uQ/Fl9a7GsxVf+cD/xHS8FyOHxeesfl?=
 =?us-ascii?Q?zHfsmRg5lk5+6vIN3ehGu+80gJOSP6POfDZ90yfkcYYRTfAZAY4qZ8GpRVrf?=
 =?us-ascii?Q?YIu3fVQtGx/HclAjPMVlDYwxJjEX93VWjCWpoKMClAAlFMvr9UVKOpMzU48y?=
 =?us-ascii?Q?sgXtFzZJPLhZ2i+Kmv4LC3S+zKcZ191wroTWiuv9cv1fTKhlGQrf9rjIhbHc?=
 =?us-ascii?Q?CihEXCWmOGg2q0FTjnHk3fCkhP5ocz4el6DMqEL4QDGWurl024Jj80yrI5uG?=
 =?us-ascii?Q?VrVWwfSmxOERNKEWUqkZ/UBBq4MSripy6W77KFy4JF+f5LFVtcNAAhdA9y0l?=
 =?us-ascii?Q?FdebPfPJC0k2w5uz+jeJTf6QaGOgojESUgbfTKGSLu6e5FTm7XM9WlDsmGbO?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E1CA7E192CF434E84569C9CA706611E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f493b13f-c4f9-4a55-7ce9-08da6411521a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:17:58.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPet40vx2uPUmxXS1zcADaV/h3Zerg9WcZZb0RHnZwF9XMgXzhdtytHXDyeYdVIYbgIBbfe7MCPyM33cqq6bww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3458
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120056
X-Proofpoint-ORIG-GUID: YbLIFrK38Br-PFmJ5A7oKcFyVDkguFIv
X-Proofpoint-GUID: YbLIFrK38Br-PFmJ5A7oKcFyVDkguFIv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Thu, 07 Jul 2022, Chuck Lever III wrote:
>>=20
>>> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> This series prepares NFSD to be able to adjust to work with a proposed
>>> patch which allows updates to directories to happen in parallel.
>>> This patch set changes the way directories are locked, so the present
>>> series cleans up some locking in nfsd.
>>>=20
>>> Specifically we remove fh_lock() and fh_unlock().
>>> These functions are problematic for a few reasons.
>>> - they are deliberately idempotent - setting or clearing a flag
>>> so that a second call does nothing. This makes locking errors harder,
>>> but it results in code that looks wrong ... and maybe sometimes is a
>>> little bit wrong.
>>> Early patches clean up several places where this idempotent nature of
>>> the functions is depended on, and so makes the code clearer.
>>>=20
>>> - they transparently call fh_fill_pre/post_attrs(), including at times
>>> when this is not necessary. Having the calls only when necessary is
>>> marginally more efficient, and arguably makes the code clearer.
>>>=20
>>> nfsd_lookup() currently always locks the directory, though often no loc=
k
>>> is needed. So a patch in this series reduces this locking.
>>>=20
>>> There is an awkward case that could still be further improved.
>>> NFSv4 open needs to ensure the file is not renamed (or unlinked etc)
>>> between the moment when the open succeeds, and a later moment when a
>>> "lease" is attached to support a delegation. The handling of this lock
>>> is currently untidy, particularly when creating a file.
>>> It would probably be better to take a lease immediately after
>>> opening the file, and then discarding if after deciding not to provide =
a
>>> delegation.
>>>=20
>>> I have run fstests and cthon tests on this, but I wouldn't be surprised
>>> if there is a corner case that I've missed.
>>=20
>> Hi Neil, thanks for (re)posting.
>>=20
>> Let me make a few general comments here before I send out specific
>> review nits.
>>=20
>> I'm concerned mostly with how this series can be adequately tested.
>> The two particular areas I'm worried about:
>>=20
>> - There are some changes to NFSv2 code, which is effectively
>> fallow. I think I can run v2 tests, once we decide what tests
>> should be run.
>=20
> I hope we can still test v2... I know it is disabled by default..
> If we can't test it, we should consider removing it.

The work of deprecating and removing NFSv2 is already under way.
I think what I'm asking is if /you/ have tested the NFSv2 changes.


>> Secondarily, the series adds more bells and whistles to the generic
>> NFSD VFS APIs on behalf of NFSv4-specific requirements. In particular:
>>=20
>> - ("NFSD: change nfsd_create() to unlock directory before returning.")
>> makes some big changes to nfsd_create(). But that helper itself
>> is pretty small. Seems like cleaner code would result if NFSv4
>> had its own version of nfsd_create() to deal with the post-change
>> cases.
>=20
> I would not like that approach. Duplicating code is rarely a good idea.

De-duplicating code /can/ be a good idea, but isn't always a good
idea. If the exceptional cases add a lot of logic, that can make the
de-duplicated code difficult to read and reason about, and it can
make it brittle, just as it does in this case. Modifications on
behalf of NFSv4 in this common piece of code is possibly hazardous
to NFSv3, and navigating around the exception logic makes it
difficult to understand and review.

IMO code duplication is not an appropriate design pattern in this
specific instance.


> Maybe, rather than passing a function and void* to nfsd_create(), we
> could pass an acl and a label and do the setting in vfs.c rather then
> nfs4proc.c. The difficult part of that approach is getting back the
> individual error statuses. That should be solvable though.

The bulk of the work in nfsd_create() is done by lookup_one_len()
and nfsd_create_locked(), both of which are public APIs. The rest
of nfsd_create() is code that appears in several other places
already.


>> - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue:
>> nfsd_lookup() is being changed such that its semantics are
>> substantially different for NFSv4 than for others. This is
>> possibly an indication that nfsd_lookup() should also be
>> duplicated into the NFSv4-specific code and the generic VFS
>> version should be left alone.
>=20
> Again, I don't like duplication. In this case, I think the longer term
> solution is to remove the NFSv4 specific locking differences and solve
> the problem differently. i.e. don't hold the inode locked, but check
> for any possible rename after getting a lease. Once that is done,
> nfsd_lookup() can have saner semantics.

Then, perhaps we should bite that bullet and do that work now.


>> I would prefer the code duplication approach in both these cases,
>> unless you can convince me that is a bad idea.
>=20
> When duplicating code results in substantial simplification in both
> copies, then it makes sense. Otherwise I think the default should be
> not to duplicate.

I believe that duplicating in both cases above will result in
simpler and less brittle code. That's why I asked for it.

--
Chuck Lever



