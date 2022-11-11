Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6455626318
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 21:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiKKUl7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 15:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiKKUl6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 15:41:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7685478
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 12:41:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABKShZP020659;
        Fri, 11 Nov 2022 20:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WJ0R/FHKJeJHlkgIXcqFzYMFjKpaRWXXruAdTOLzDhA=;
 b=poYvK+whZ83t+2CaEbyfzXE/VyQkAGcONO191l/mzwCLOKQr+FKMMoOA70i2Zq+UNKeU
 d6gY21R72Ia40mlTPx29EO5yphF7Sjh1w2bobWXYttF05SS8G7no0f1DWumY9uQRRSH8
 fNjbPtGOy3mLcbEUgE25HJYdsN3bEPmZ05kAuCRwfIcU2E+wDlshM+nn8MWFv/+cdFIz
 LByEe7RVZa8pHZQ3bd0Y1Kj69c0o2leu4axPLXJ7f0gYFUQq9uxaoCPChkREKzOfbCrQ
 tZ9LmOvW3dg5R8Js+fKFy3Tl254VgYIymTG5VX9iyqbLZG0yfzuC08MvFz8SX0JZdGat ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kswfag0kb-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 20:41:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABI3VZw009073;
        Fri, 11 Nov 2022 20:29:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqmwgqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 20:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqOmmUKa7qTlToLz9p/F35Hg0LkLLFpqMuX7S3UTOc50mAN1fFoDg1hLv8w26vLPUBwJWXMhCmgWIHwyjG98x0LHn76YN1i85voCGrzSq6Jfx12xPQ6V7XCTV16MMCHPQ2HIlaydiQUYWkeniClCTHILXXLhKnNeoznfPXVZ1AYZ/iPpy84fs4jcGk3wQtxxJNkPIw2za1rcVOHBwJETkiok5a+XO9pT+9HrSTrTnqm0k666OG5pb9hbWUR6mz9QIXdzcfAeJ2oGABjD8MkU0JQGxwSLrxYPfLn5MFAsu0Mu8FN18ETjI8L7xTv+gj3g5/TWVOPeVaQEO58OrMGQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ0R/FHKJeJHlkgIXcqFzYMFjKpaRWXXruAdTOLzDhA=;
 b=iSG6HvxGezlqXpXr1VjX4fEJHNKUPZy3yRCtSPZEmVPZvXzEfEN2SaHw+bekGv6FvbVBQXDk8ZYE3v8uIVP/v7YZdqeBv6oAi3KnaoTpWFTfZ8LbCT3BOz7yySqbgIQpy1wi/bdJP1DfVBOm5x15MJ679T8Hy04S4HsfxuQwHcm8xZr1zz42YKTkGbN/qjg+GdS2xVpMYjDkEmtahFhC9GKMtHhkepgFRN34H3isZwe4lkSNAm8jY7ORH38XLAd7WdesiNYH6tWi1mytyaRucGiflJVSgM1w2wltEDwQai33NAzeBYtI3XN/J4yOC+gI1blKgOAIg/CUT7FbQaYUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ0R/FHKJeJHlkgIXcqFzYMFjKpaRWXXruAdTOLzDhA=;
 b=cG5knK00A2B2NxXIt+zTatZqIZjVsc1ASel6k7D1XlFKKHbxf7u43/5ZVsZjnhYGIMbvp4n8p1rImgWxLUsgYILGMvawt/VXLnhF4mJkmuGNlW+aqEmnLSKcTOuqWty78o1ywgkqIwpzNa+JJgOpfFgQHCfAvOVdPIthKBNAIoE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 20:29:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 20:29:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] lockd: fix file selection in nlmsvc_cancel_blocked
Thread-Topic: [PATCH 3/4] lockd: fix file selection in nlmsvc_cancel_blocked
Thread-Index: AQHY9gTwwKmHpOWzOECaqHw1tBDcK646LKuA
Date:   Fri, 11 Nov 2022 20:29:54 +0000
Message-ID: <1AE4E7CF-F76B-42E8-90D7-5DA52AFDE66E@oracle.com>
References: <20221111193639.346992-1-jlayton@kernel.org>
 <20221111193639.346992-4-jlayton@kernel.org>
In-Reply-To: <20221111193639.346992-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4353:EE_
x-ms-office365-filtering-correlation-id: 7e0b1a12-fce7-47c5-142c-08dac4237e55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loxsVKC9yVMuZMkOy5g07y5Jh4VpPyWtv1k3YNU3NJvtuWnDFYM+iECbOOvl3T3bsvZSwLM4UCS10CJmdbD16amh7VmVCtB/guju/M+Gl0ArySfBBbh1Zd5czdQEHTf96TPT6oQD+SlEL4zO0luSRsAGNSWXA9zcC7rl6mry7TZybVqIOcAV3B2UP+CWJT+ixAACWWhXEh6iYjIdAZYJ1tanR4FG5rnsEUImuljAPqLOobFUxuCt8wue4aBgvsdcZRMOyBtImRWTOqGg1qK5RRPpprAoPw4mX2X7/Pz18NlOH0a++u3q11yNb8SmR7dw60dp/kiJ/gmFOA7tXWpPDjH16O9y3lwNktCA+yvf59MtIRBPqbxt9Kqms1+CS0PjMNLBBU64oe9WXGEJFaKyJ+bQXwVzE9H482bFgHdr1ZykR+exQ2Ups9GkOnYmkedK5cwdsMkbMbO+WFKAzrN+INU5SjZZy82oL6ebZqTD6s+/DtPbM+jBDlRDrylMsqdzFSYOxWj3/Lzk9CsuIXc5sRVDZtSRwxw+51OVZZd7U4wE3MEA203K97uDu7f1RJMIVmj0vIXiLyqRLkJeBE6RQgU5wbLEsyemmUOMv71mmwrTNAa7k3McItwG5M+1Y7OCmhSjDFI9K0A0L8qv6mzUktcHZEM9jGrevq5IJIsiYAnJaqxItapNxeLowM205JjBKgYfqoxTEF+7+lGhlArV1919Ogtu8nr8XkepGNQFS+Bm2mwFxjKVxwC3jpfGcPxu3L0TnjqyCVc0NwMYWhBen0DnQJAcsoswBcYUv8a4jCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(186003)(2616005)(26005)(53546011)(2906002)(6506007)(83380400001)(316002)(54906003)(6916009)(38070700005)(5660300002)(36756003)(8936002)(38100700002)(478600001)(6512007)(33656002)(41300700001)(8676002)(64756008)(66446008)(66476007)(86362001)(4326008)(71200400001)(6486002)(122000001)(91956017)(66946007)(66556008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RfGcv5bU1VbwNhJwe9bOp77djzZjiP4Nc6PdJQb4zBT+JBFiP8p4PqhOfG18?=
 =?us-ascii?Q?oOqsaG2vugVtWH+xjNvxejmnCNXVyT8AqF8kWkk/ims9khVJ3lqFu8VHL0VA?=
 =?us-ascii?Q?gtiiHpWy1kobPCdjZHKy63MWETDR0Ll6i2C2BcrcVybZ0dztPBwXls4zpN2n?=
 =?us-ascii?Q?eAyz4ICZHBwYyqrFYc3+R2N4fafi+l/EWJEBSv99LoFhIhltbH0EUpvx5Bk1?=
 =?us-ascii?Q?yqYXV7he2Ag5TYuWCNtd7y5nWZQzSX2ivhoMcRrM9zncT9vhU1hHdIWM9928?=
 =?us-ascii?Q?5JIJcaaByyLTVtFyqM3Ep683yGe7GlVF+BezxMLf9A14NDSMkRHm3tAST38x?=
 =?us-ascii?Q?Ghfy4WnvIynSe5jMehITO0lr+Phaoo+N6Owz32Z2YXBEJMXugiOXRVnqUkV5?=
 =?us-ascii?Q?/F8E5lSPmqwRKu7THVS055FFc4gGKFT0yFNusPphx/p25yzQM95hq9CPHMZl?=
 =?us-ascii?Q?am8E+ODzPLD8q3eJiGsYWmxMGQuw3yAXRGYFJOjyUM03a8Jh/yPUMnCgVN7v?=
 =?us-ascii?Q?M93Bs43Ib2HHv+uwft571uz7tTcdaIJELu+hSkkFgR9VSGTMx/kF26BD/vSw?=
 =?us-ascii?Q?jNlxBWIqv9yJVgF16g1OtDmTy84kScgYdmPJgBVyYMsd1kk15Re9brrLKi1P?=
 =?us-ascii?Q?iJxPeCa21Nr3xZcvQOzrou89F8CtqY8d9IM16I4xZuDmTohMF7P2RUoSOwP9?=
 =?us-ascii?Q?mTdZu4fLUv9ucwNCNH+EUEV4qac6ah2k6Re0cdZPd+ZFSRaGPg14HATLVkk0?=
 =?us-ascii?Q?M7kPQA8iR4RNZGevxgRuUUr22D5infC2uN7zsWKGIvz5Y8F1N9OURw/YDu9E?=
 =?us-ascii?Q?vh5pFHtV+wMFcCWD4znNo/Ok+74ciA8pXnZdQ+TGfjY/Ca1oft2xp6+hnGEf?=
 =?us-ascii?Q?p07PVfLsOj8+gbl7ml3Ipy9ljfZGGOK0bdeCMM8bpEMniq0X3TGhXRBVC7Xe?=
 =?us-ascii?Q?nLkwAi3x2+G89R7kGnGWw2/znvujQTfOOkQAekM9yu6pHswXNd4UiOZuuIYl?=
 =?us-ascii?Q?a5YRdIeDkbf/qXQ1Rpdy+etVerRybikUVf8d/X6GHUf1Hkj9CiyQzZAD6VFu?=
 =?us-ascii?Q?fbFnmd3Vm5iojMliVTD8uhx5owIwT+YF0KFGwA63GnEY1769GhhYkO75XBUM?=
 =?us-ascii?Q?HqqfBxnAJNywAV1ox1cNRSuAgJJ6Ys/MUgshZJbhiwFPxqlE7Jguq1Ogj/mF?=
 =?us-ascii?Q?1g+ebfqwAszkS+AjCqiXLxm0OjtCskvtSI776u1a3QsOiA00e+kjEB3OtkZr?=
 =?us-ascii?Q?1l/Zh/vkGUB2UEoVFAR/aJmMbrAV80azQaOt4SD7uTCmpZmUaEKpxGDUr5zI?=
 =?us-ascii?Q?zte/ThSpcI/wty8qePEMJHWznle3TijGNg+jZpGd9sERqkkBixWGV8f/0TSC?=
 =?us-ascii?Q?2gsvXsdd59/Xm0yufJ++JjCFHOlch7M3c2gfC8rzxbCiTXtyPEez53MTz/AR?=
 =?us-ascii?Q?Vm1WFfswc8m10vGV85ievNFBaYKjgF0ckhgwvjjEelwI75lsHFkeWK4+2e8m?=
 =?us-ascii?Q?gscyk58q+Y/7XRfQI/futeW53nB+a6miigG4qiliMHEAH+K5zZTK0TalSCej?=
 =?us-ascii?Q?XVMzXVyfGdEq/bC/poBEjZh9ExDl9lxp/ZGvflOi9ldmXV8kOutuTtiQYdOc?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7BB9F97E97BF740BB363CD03DB99AB2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rBLWsJwb5HfgvBV4gXUSIBT7w6YfDgIx6zO3Q5Iv5pxyelAOL0UpeGJusQcbrG3g27YIVPsc9pwmbFTMxLR5K3WHZ8CDjBOYojoGpFhZQd9hT22T3Uki4Qae89PKc1z2Zb0kMsJ65I1H0fYzhBFtnS9S4mWWQkV1Qs+qk4MuBJhafUW7aRQ1jLSTmkKNvcjQ7By2gXwxh+vdM+1Df9zQJZDLBIrqHv8Ok3VzYi7MN8Hyc1GhpaC7WXiuxCmUDmajMUb6cQilZpIq/xCVXZfYzNOlh4hkImZFeuPKOhVUcgoURL5qlJnj/2XcNXct1YU7iYNvTDdX89rIcGwPY6gGsVJMxUOnexRU/3qdd3lYrjpqME+9mxAKQGr/YDhihXmQ4OKhKH6KfcWbCdXKElGIxwa3+vC4QS6oiNx259wgqwWefSoGOOUc3FE9xFI0AiYAUdpDw1/ZgK39YF/oR4GI22aZBg1hxNVU1/oesYI7/qZVEMAGwCtNsotsO9wqEDkAzFf0SxfVNXkBsQP2h/WRSvdXeBwznmBDD+eSa2sLkRLWtb/rvE5eBes5MHt5icKIh6dQ3JVw1tUxKUC6RG8s2iFGqkHlDL73K/+noN7GXxhsl5qkHrJ+gqrTZPDJ/+orD0YISquzxMrKzWVfz14NQUhWdpWYfwbaqFFGjxtzmj7TIKCzVcHn+3Gw0z/8ItUUFHHsLMj6cKYgXs3ZoSSgM2Dv3iBB5MSQF8VN6TtHyRpfUzsdbRH4uFP3NrGE0osc8vIKpcbxuOlqa6GdsOLwsXvTc5K3w2rgpwG6eQZBPAeQXf2MpXj7Ydv//t1u6BsMqTm7FkPvHm/0QELsFtyU7g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0b1a12-fce7-47c5-142c-08dac4237e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 20:29:54.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzTW/mtaSCbAMjrTJj/Y/a2Ttg9iD0FPIFvtl9odMrXAFM+Y+UlZK11qp2DDSlagdO+qlqcLaa9kAewAfQgdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_10,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110140
X-Proofpoint-GUID: CZkLwPIPvwRd9bryrlNuAvrJQbbaR8w_
X-Proofpoint-ORIG-GUID: CZkLwPIPvwRd9bryrlNuAvrJQbbaR8w_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 11, 2022, at 2:36 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We currently do a lock_to_openmode call based on the arguments from the
> NLM_UNLOCK call, but that will always set the fl_type of the lock to
> F_UNLCK, the the O_RDONLY descriptor is always chosen.

Except for the above sentence, these all look sane to me.
I can apply them to nfsd's for-next once they've seen some
review on fsdevel, as you mentioned in the other thread.


> Fix it to use the file_lock from the block instead.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/lockd/svclock.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 9eae99e08e69..4e30f3c50970 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -699,9 +699,10 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_fi=
le *file, struct nlm_lock *l
> 	block =3D nlmsvc_lookup_block(file, lock);
> 	mutex_unlock(&file->f_mutex);
> 	if (block !=3D NULL) {
> -		mode =3D lock_to_openmode(&lock->fl);
> -		vfs_cancel_lock(block->b_file->f_file[mode],
> -				&block->b_call->a_args.lock.fl);
> +		struct file_lock *fl =3D &block->b_call->a_args.lock.fl;
> +
> +		mode =3D lock_to_openmode(fl);
> +		vfs_cancel_lock(block->b_file->f_file[mode], fl);
> 		status =3D nlmsvc_unlink_block(block);
> 		nlmsvc_release_block(block);
> 	}
> --=20
> 2.38.1
>=20

--
Chuck Lever



