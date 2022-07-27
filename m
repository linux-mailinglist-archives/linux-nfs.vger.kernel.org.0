Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71DE583184
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbiG0SJf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiG0SJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 14:09:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E074E0D
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 10:12:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RH8wW8023838;
        Wed, 27 Jul 2022 17:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AXwGof80ayR4hg0W5iiPhalDZ3D2qDMf3ZC1ivcrK1s=;
 b=cHsMdoTegRmK0rd5g7m1FTtwyTFt5BOXPiK+QIgl18MyF2VE8L8tfqRLHsC4B4DKSawU
 Fmxo3TpBpT8W/H3uuMDUkvIswN773F3WHZxBDzlOaVY5sWcQpcgPPKA6gEFDAm7aNeMB
 DT+uvCpNKkS1PnzoZW15/1QZ+XjxrQLa376JM/gbJiB9oCRtsl/vEa9ezCxxW9VRn5eG
 AhEnK41vzYdsFd78BnYPam4CMMeqyZW8PTdz7wmBx8hYQoGG9qfBFbJ5LBAS6aDjieei
 7IHsHIjrLM70Fk9+miLgFMxAMreNceCQcyDPV4tDwK+eif69IcSkPDwL9y1mAsvowatG Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940t32a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 17:12:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RG6W4B019886;
        Wed, 27 Jul 2022 17:12:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh639j7mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 17:12:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCCVWGShTOARJcKhOjhVrT1tks5H3IwOFDrFAvr2JicvZ/TozRuNP6eAlfM7LqIUUSb2oacXk8JvNYsi9yjg4d09/LUkbJUAgFpLrja4G6jtK/gAyN5TSyC1oHfRHIvnbJhczVxvHwbQ3zrnTP1lGGDLqbyOdPSp+2PwVRBtdVwK2PcHGj/BF82wk2bNCqlqlgTlCIEQ1FP/dljmvEe6ZKOwOME0W+zD77rc6VICfMO3EThndNrfHFxfDxCAfJ4lI+0L8E4Q109Y6rHgRrRr62oDnvTPmgb+Pk6AmqiGw/ErP2QMk4V6G71I6xTcih8CMyaQBhB76gGvqYkARxrBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXwGof80ayR4hg0W5iiPhalDZ3D2qDMf3ZC1ivcrK1s=;
 b=KUdSXYuWd4oQzdp/5GeS2I4mFCYRwmIJhZtJ4W8l3hHCRoXDhg+c5HNPKnqi1F+98yga6em17ywjHIupY3nFDX1z7jUQG3RjI8int12U2xoBBYacKw02UKuUNRCb0k59ToV5S+ATfR02OwY2ZRs3tOd18RO4hOYBK+VHRv3RLLg/kXBJGVx7F7YwiN+z+veQyfq2x43cXvWikz1l3gdKcBBeDSYPSTmpRPuCkA9o8WvONVr4esUE3VZ0hD4U6CFslRTrx+dMHqOSBctsvGRiZLP7+rUHvlGpxXNCOYReblNIqVOULn+nqTBjEu4dHKJ/AfB7xMfYb3EVn1umnJRZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXwGof80ayR4hg0W5iiPhalDZ3D2qDMf3ZC1ivcrK1s=;
 b=QGK1zE2h17hDt1+QnJeeAwM67vrjDJi655QXx5XJ2IrnqYJLXk3IYR6PTXrn9l0dOUnliU/fEZlabQFugNV0isq18+gLSAGsI14bqELydIH5F6HXrcGfRkXZIHI569aY+a3DEO+0FYgsbJaACtr92AJ4ky1jihJH+5+Rje374n0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2434.namprd10.prod.outlook.com (2603:10b6:406:c8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 17:12:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 17:12:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] NFSD: clean up locking
Thread-Topic: [PATCH 00/13] NFSD: clean up locking
Thread-Index: AQHYoLt1dDclFfeLe0KoCxvHL7Kak62SX5kAgAAW7gA=
Date:   Wed, 27 Jul 2022 17:12:06 +0000
Message-ID: <46514AE1-441F-4079-B880-35585632E2FD@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <9f3fa578841067378e7f5a1c26ecde90e66c90e9.camel@kernel.org>
In-Reply-To: <9f3fa578841067378e7f5a1c26ecde90e66c90e9.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75cf90de-a342-487c-2cbc-08da6ff3224b
x-ms-traffictypediagnostic: BN7PR10MB2434:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+8UZq+VYwcpeYxZUCIPApww5gPG1FiJpLQZzjEriTp7txn+XGmMY7p4YYV1ltzi6i4yisu8awcmCQdnnTlkZG54cnAxogsxwZ5qn196UAn4DeHWeYQvqVpOgw/1TlOfs2mrtcIBs1O/WobK8G2tRrbzohZKEKolsoh/bsHhGN5hYkC5JwKUWTZQAB8Uo11XepxNTCrZ1JHIjV9T+AH1aZO2CFNYqWeg1J97QbJV+u4u1q1TOznrpTeHP3cGTK1ncIH0HRz5JSTq8VV00fq/JVuxJju7HxqLUAwdFms0hHUxrp2u+ZufLDUCAZBhv6jav3g9kM5ExgDIBLJkj5T38HfNyFkcIFupv1WPg+FzydRxfGP30b4YhS+D/MthBqY5hK7haIuz08vWqsA/9nGhp3Qz0D8YEj2iX5R7aWbGWxYr873gryWTIEIa7xUVx/N7j51lW7cJkBeyOeS00q8ioaVjiebNEgVjyuTP//CYFbi/QpXNiaVDxnKPXkoT3VBUCkhVutAm/Nqkt3Ix586DVzAinaKV1P8UzmGoslSpfEbhzQKwwmJ7vYmViH0nmYxU/YEZVzJ4RduJQWzGew8yV15q5nfD1QMX9Fo6KoKDC85eVqS4AfX50JlrYIntOVcWZA/fRbqGKeJ3sBZGpxaafyFvOPfBl2fkfgG0Zeg44t9k51AHqTgp+QPujisZlibNId6T8hn1kAP9Td35DQecHtQyY0w8p20o9okn6tv3isDvyItEIqUpVU2oHs8EzxcOnERs7HY4HbZEMMqJfVo6dGbuEvEjvveRj96ziLXTk5PMBTwaN+3YpYLLBsqEG4JsWbxL3FWgRNRf/Z/QJCYXGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(376002)(39860400002)(71200400001)(54906003)(6486002)(41300700001)(6512007)(186003)(478600001)(6916009)(76116006)(66556008)(2906002)(316002)(53546011)(91956017)(4326008)(64756008)(66476007)(66446008)(5660300002)(66946007)(8676002)(86362001)(6506007)(33656002)(8936002)(38070700005)(38100700002)(83380400001)(122000001)(26005)(2616005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vWcFngspx2MXagtgrvdDWFdcHJ5iM0asevRDVkYkvVMWnDOCuIvDwmAjXC2y?=
 =?us-ascii?Q?1woYfz00xSoYyP/+OMpmR+beWO78kwUf4ZuoFzRbDRn8Zo1XUMB4h45iqUxd?=
 =?us-ascii?Q?+0MJH6WLzL4uqlUXRVpPPsJIYmvnXK7vV8oQve59LRJ4nCPTKSOW8vLuWO/h?=
 =?us-ascii?Q?l+rKZRMxen45HIcBYGCcAVNgudaPSBeJPjBBDT7j6kOnpjY4oxX9t5NHYCAh?=
 =?us-ascii?Q?0OPOzYDncWSO3DD0DhjOAE8Aow9FP520NnnUGi7c5IAu2olbAdzVbwV/sKCX?=
 =?us-ascii?Q?a/vIzC2Nk6gQxwEs3398kTj7ub01Bm3IVEjJpnPKi/SDNeVNU2FeqciN8tvj?=
 =?us-ascii?Q?OBcEDVjcju3UBEV+AFGqcTKsfboTS0u1iayY7sxUoUd7l1qZyDCIMyZC5YH8?=
 =?us-ascii?Q?/soLNeO1S5RHYwtagbMnUhNsRAbt6ZlVpdvhJ8s5yf84q4V+X/kGIyyiJaeY?=
 =?us-ascii?Q?SIY0ufpXtNJQ7jQzcq68VG+a7J9sEve2N48pejdjLxPsKCFMPE/PkTzu3KLV?=
 =?us-ascii?Q?I8jjl6I5waGI+F6WOa2vnpMCYZVNPsKN5zrW4anAzMFj4YzgmXiRtUh97G9m?=
 =?us-ascii?Q?kh+snrw8NlY2zlmRgCJn92IUyiriARx33FOdG4U9gj75g6G4fxmjqeQtI9sY?=
 =?us-ascii?Q?FxJknByhxwuNBfIUnIBY5o36QHHCWnGD84BMi4orxtRgTurfm1xVcbo0jkJL?=
 =?us-ascii?Q?YdJ1fkQVmmbNStv8WnFkhO9zv7Zq85Dvxt/fWFFcz4JrWic/+Y+Ct4HiOVXN?=
 =?us-ascii?Q?sbT0atakK4LLb+/KZGe6whfcgAucuSvt88T3+1qwZgOdpujl+eplFMxuAWdM?=
 =?us-ascii?Q?1Zm9tn/p5MNawq74F9m3gpse5gE3PJCZ5Ok8xNmbrjlmwQ5liDuapM/+AOcC?=
 =?us-ascii?Q?xB9TjxOaIzpdT1XZ3g/H61Nb17xldXSp27YqIMJeB3Rg8+xIX8lqsSOYn7GQ?=
 =?us-ascii?Q?PIoKFFoUJp5TDBeYGuKk7X6t6u527gQqqhOZuI0V8RmdGubtuKEMr2toofsJ?=
 =?us-ascii?Q?Qq7n7RAFJO4A4d9nIPU8kvaT342QKPFFkgcsMe2eCXWRbmX8Mr1LJX44tjbf?=
 =?us-ascii?Q?Fcd9zEjElUfydcvqgpjp/nKxuuL+gzC7m72J9gYHNS65FFdNV3QDCOJzxCYY?=
 =?us-ascii?Q?jsqRp0hne9Um1lz6KQbSDo8DIb+ZGXGgQuQxvDCfoKHbmTyhH/hmHuxntnEi?=
 =?us-ascii?Q?z7+JSiWKQUVV+xLTBTcd2e+TQwZrAmgKhqyRTfzkjRZNMqXBpkgpg2bc9D9r?=
 =?us-ascii?Q?EwlEvWdTyXlVqIM8t3hLQRQrdwnL6EAx0UVfGtB+WCzrq/s+0DwZkX/i37wd?=
 =?us-ascii?Q?UgKW9PpVT2z/Gm7aXDdmU00vlTP193MIVXiYexoJHOYwxacfOkLjLngXStj6?=
 =?us-ascii?Q?dBM+6suuUCIB/NcyMdpCYW0r3cpgJq8Sju7Pbw1u8GB1bkJuTXnu5XfxSw2S?=
 =?us-ascii?Q?Jzr8J6UvKT+wV4z1pCqqKtTmBdxMSWR4HqsqXiaQl9ixOsIxyo6oeBX0xhHM?=
 =?us-ascii?Q?K7P+JLy/H8oWJOmHB+MLFVY/6TtYxRBiXeS1XjFhbQ+m91fcb6l6UUrQN1/B?=
 =?us-ascii?Q?ozme6s2LJHqkOAchG8Pkuxmq0NqPlPC6P9mUi9QuJBfnFfLlu+MIecQXt2ft?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6F3FD74BB42324AA2AFC1D7C2A5E04C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cf90de-a342-487c-2cbc-08da6ff3224b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 17:12:06.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1Nyt53AAUFonucGlGm8jSkvEfFPtLibzzSXQealDAAvBEL19isTq3Jf0ffFEWyO8CQEzm7x4qUIhsP8W3rdpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_06,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=754 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270072
X-Proofpoint-GUID: 5ZRwjAKmzaEo29y-Sth3lrxbbWgWK3Wb
X-Proofpoint-ORIG-GUID: 5ZRwjAKmzaEo29y-Sth3lrxbbWgWK3Wb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 27, 2022, at 11:50 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-07-26 at 16:45 +1000, NeilBrown wrote:
>> This is the latest version of my series to clean up locking -
>> particularly of directories - in preparation for proposed patches which
>> change how directory locking works across the VFS.
>>=20
>> I've included Jeff's patches to validate the dentry after getting a
>> delegation.  The second patch has been changed quite a bit to use
>> nfsd_lookup_dentry(). I've left Jeff's From: line in place - let me know
>> if you'd rather I change it.
>>=20
>=20
> That's fine.
>=20
>> Setting of ACLs and security labels has been moved from nfs4 code to
>> nfsd_setattr() which allows quite a lot of code cleanup.
>>=20
>> I think I've addressed all the concerns that have been raised, though
>> maybe not in the way that was suggested.
>>=20
>> I've tested this with cthon tests over v2, v3, v4.0, v4.1, and xfstests
>> on v3 and v4.1, and pynfs 4.0, 4.1.  No problems appeared.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>> ---
>>=20
>> Jeff Layton (2):
>>      NFSD: drop fh argument from alloc_init_deleg
>>      NFSD: verify the opened dentry after setting a delegation
>>=20
>> NeilBrown (11):
>>      NFSD: introduce struct nfsd_attrs
>>      NFSD: set attributes when creating symlinks
>>      NFSD: add security label to struct nfsd_attrs
>>      NFSD: add posix ACLs to struct nfsd_attrs
>>      NFSD: change nfsd_create()/nfsd_symlink() to unlock directory befor=
e returning.
>>      NFSD: always drop directory lock in nfsd_unlink()
>>      NFSD: only call fh_unlock() once in nfsd_link()
>>      NFSD: reduce locking in nfsd_lookup()
>>      NFSD: use explicit lock/unlock for directory ops
>>      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
>>      NFSD: discard fh_locked flag and fh_lock/fh_unlock
>>=20
>=20
> It looks like the last 5 patches are missing from the posting
> (everything after patch #8).

Fwiw, I don't see them in my inbox either, and they don't appear on lore.


>> fs/nfsd/acl.h       |   6 +-
>> fs/nfsd/nfs2acl.c   |   6 +-
>> fs/nfsd/nfs3acl.c   |   4 +-
>> fs/nfsd/nfs3proc.c  |  25 ++---
>> fs/nfsd/nfs4acl.c   |  46 ++-------
>> fs/nfsd/nfs4proc.c  | 153 ++++++++++++-----------------
>> fs/nfsd/nfs4state.c |  71 +++++++++++---
>> fs/nfsd/nfsfh.c     |  22 ++++-
>> fs/nfsd/nfsfh.h     |  58 +----------
>> fs/nfsd/nfsproc.c   |  19 ++--
>> fs/nfsd/vfs.c       | 230 +++++++++++++++++++++-----------------------
>> fs/nfsd/vfs.h       |  31 ++++--
>> fs/nfsd/xdr4.h      |   1 +
>> 13 files changed, 314 insertions(+), 358 deletions(-)
>>=20
>> --
>> Signature
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



