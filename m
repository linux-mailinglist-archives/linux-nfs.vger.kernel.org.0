Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE579C429
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 05:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjILDbf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 23:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237895AbjILDbS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 23:31:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748BEBA5DF
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 19:24:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJgWaB021332;
        Tue, 12 Sep 2023 00:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IE/REAUBczHuxeL5ICKQJYA/rjFPPwngr9Sc5xmu+/A=;
 b=J3h4kx6NsRPHAcLglUEXq2hBE1Kl+uGG5pwWzywLG1JrzDgQJNprA5Rw2MnZwEKQrZVK
 KdoQx6jMJbm0eEcEB1f8SQbMGAc6DKzip+7QGh/kn6YnkQVcgkVCPv80XTk/DzyeGHJf
 +JEW1cSwBFRMXUR21R+bxsiOeXc/QNY5vyDpA8AMPKbT7yN1yzVTBIs9E2+jmxuQarMZ
 rWgPZEoOHyS4+zB+m0tnR73XaTmdezZvp/BFI/ZUPc7dtUSsnGNB/eYLTZxntzAERIFZ
 cpaB9idvkb9UTJPU+NQjoBhi8VcpNuODyQYV3x0/YuNuRy/YUR7LnpB/sFXlni9UBVD6 Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwqtqu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 00:45:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BNZbVO022991;
        Tue, 12 Sep 2023 00:45:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f558hub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 00:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0MUb9pb3PDSbPF/QsvCkh9EGH9vhHGs/iq0H5075W32sFcgAqI4xbeyRu1fuNePKc4nxiZBFeHtXk+EkrSoGV0mbODu9UGndYRH3smSx3MeV9ANLpUZ3E6ZOS31rzJPkfYzmdFMwjNi0hdlk2NK3W6e3tfZkzu/CqZkyLW/kXf6O9uKS86DrKUTW2oopMFKHyjVqUjXNlZ4xEoXlPOn4PGJLOfjxdWWBSzGBNXkXpQ2/PwIUMdYqlMeUWocx+oRuVMiOwoRrLlgEBelCDvTGW5GFG5gpqqidIreHKRAJWtywvWGteSsT65bq7sLP7fjwf4nBz7A2JdY66uFi6YXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE/REAUBczHuxeL5ICKQJYA/rjFPPwngr9Sc5xmu+/A=;
 b=hwZJ/iT3T3JVP/TvT9g+2fes0l7XJHNq4BzxrMUYyOQmE41AtfT6ZukIz+agY6hOmpax2yYBBc17hVn79ptV5qZwF7iCSUANv8CVe0hsiEm5JDUCpbVZYPJeaSuQ5zCEEZV7hNzrWbxpIZCropE5c+G21eSA7dwLJWRJis6CxDbTm2f53e5jZQd5ZBuABQ51iZw5iBEEbB913xJooUGVWL0IBWHaxTX6T54VTzH5YoYk08uzukc/5DW5UXhE7uRo1ovcDD9Z+ecDqM30Ov5Im4/4K5wBvtpG0iZr+3FCQWTgGlEVXJGEihkw0ZwIQwu+gXYKsPs1E3ERWpjh1Q6PjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE/REAUBczHuxeL5ICKQJYA/rjFPPwngr9Sc5xmu+/A=;
 b=tqErfIGk/OXzI5VeDtZiyHAzWGeBh/d2Ln33pAXuWvrOJ5isAL5oSSii4hgw6YLAOcGGehUN7uG7ByzxP8e/hsa8wW6pSUBk4dmrNMQiglKpKIRJTkZnTxaYhEN1l4c69AG0jECRwRPGJ2K626zh9bil5wbi7RfCJQuV8qFZG8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 00:45:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 00:45:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
Thread-Topic: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
Thread-Index: AQHZ5ODKf/tGr/TkjUO+olrPJo1n67AWD0yAgAALTICAABU+gIAAGZGAgAARl4A=
Date:   Tue, 12 Sep 2023 00:45:17 +0000
Message-ID: <0B4074FC-C08A-4233-AD9D-FF7C405ADCF2@oracle.com>
References: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
 <ZP91EwHCt0/c0jvJ@tissot.1015granger.net>
 <f754d8a170b967d1523d103837eaeeb5e9a6c85b.camel@hammerspace.com>
 <684AB86D-ADC7-44B0-BA54-FC23DB0B4670@oracle.com>
 <dfc7823c29b2157290828c360e9dc7c64536904b.camel@hammerspace.com>
In-Reply-To: <dfc7823c29b2157290828c360e9dc7c64536904b.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ1PR10MB6001:EE_
x-ms-office365-filtering-correlation-id: cdf3de90-fa3b-4c1f-b02d-08dbb329893a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UFh+BG/IYwXJ3l9DCJPkKgX7qmjpT/Zg65Q/2dg+11pUL2EFP1/c9IB+xnBvbAzcu6N0qtnH0wAffPBqqrmYng1KvQeGaT36cXhoLR5k9axXgpVgCs9l/kcrK2blXoCdVUGiJzxt83nFTQFzRu1FbxlPp3LjqlfJ6NDrvSRmWzZafhL5xap/13tEcg9S52oBDxCl5qH1pPW9zjGx3OK7MODaQV24jAeITwBRhT3x/P2RfYLXQErssM00XIo7A+vQT0RQwbv/Q1rdMYuSZ0GHYv/j+vquKU1md00zw33YLQnmzf0DmfQzjof6XbqPFbYSmcS3Mcjja+/eG2rybNpg/V1thUof5bOHFmzsazIAkw26k0bXQ1iG6RK1BUKKlf6DLknY8mkjOKF86JM07gkc9KJlUCoWr+as71ywP+DzAP9qqxYnnA5LJZGj/W8g/SKEVNc+U0/BKJL9pi+/o5+jcXQTKVVTAuSrNr4ibJn/rIK+GR2mWcep0aeAE1P66q+OvEZbgnLAHaIrnjUVmHzs62uf7xUu4rL5tsHq33LnIvN2zAOIiiCXAklgDqsmpz1r74YLH6BiRZEQKsLISf6Yt/4HebZP+fjeLEPmuhUeQM2/7FZRQkbAQ9xyij7qHAfc5R2bY8mYG3mOviPvsge6Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199024)(1800799009)(186009)(64756008)(76116006)(6506007)(6486002)(5660300002)(91956017)(8936002)(8676002)(41300700001)(66476007)(66446008)(6916009)(316002)(66946007)(66556008)(2906002)(6512007)(71200400001)(478600001)(53546011)(4326008)(26005)(2616005)(83380400001)(122000001)(38070700005)(38100700002)(33656002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AXLhWQ0DqENwyboieLWnLV+cjnhOSiTek7VwdSNpSfiZdSnBYx+/7BpIIT0f?=
 =?us-ascii?Q?2uKno+mcHryMbPZmInBDtNT6/yjnjIBaBHFfrp9UJGiNXEfVPudUb4dvaAiT?=
 =?us-ascii?Q?Qs7z3x4I9BzObUPd0XU4woxxK77KKE+l4rPNF9kj4ZjVlWOwCJ1wJwfpW7tG?=
 =?us-ascii?Q?nAjTsOUKL8rrPr9nktpNCO28ztzA6C3fQkSRprqNh9+xwgEfOLFmHtpQ82yw?=
 =?us-ascii?Q?AYjm/miL2AcflvFDeUnnuRFga+QKRZsIA/KLvaMBmL9UNO4uLfxsah6pkFrv?=
 =?us-ascii?Q?iAJJEEAJD2ybcIJLCVfjzCwVX0iadRUF3ONxqjDGAuJdpWU20812LSU1GYI7?=
 =?us-ascii?Q?ry7ANfBsac31ZFx5rhKIti1c6PgqbKPe7ZoAtEjagij2iu1QJbFsglH146WO?=
 =?us-ascii?Q?Skr6Wz3xDEyA5j1s7Nmu7ECtAFFWqei84IEZmaRNEzw7YbhjayK7vMC9d1nC?=
 =?us-ascii?Q?b4qTaEJ9sjVUVexHRVOpld5BEGmy+qo3A6Ca2pd1Z+OnbNC1yfyMqmJlgaqS?=
 =?us-ascii?Q?Ovid2JbyAXnZr4tS+yBzG8/1bhMTCOzPhJrjHLE6yMsQdQfDpucQxqZ7IinD?=
 =?us-ascii?Q?bmWYhCylBfEmWWG6jezeYnaAFjfeeqkrEa42bd9/M7wETFQyBoy7U7zetfEH?=
 =?us-ascii?Q?ClO6VTqgbMc1myUyVacOWYrMZJHFuec9ZovCNXV7ntsKmcTEJQ+0CBEkjAnz?=
 =?us-ascii?Q?BZhmI1IrbHR5/jKVX8M9IQxwP3Y7rW0wBy6+MGXbm8bZnhqFcSdPKCW4zbm4?=
 =?us-ascii?Q?Jz+S3819bDm1JvfwlB5rbVdUgnFzrItf+ZuA6wLmYtC4v6XqmEILY9l5jUSc?=
 =?us-ascii?Q?+LU0JdA3gwsBDQXyoki8pRjqpSi+q062eECxF2nIn3SziMH/FcQf9s/96Uf0?=
 =?us-ascii?Q?T/LyBBnhlC2PUzkvkFfdlIT+amGc4cQUY1NMtLMDCQZxgYiYX9WY8Fz2bVe1?=
 =?us-ascii?Q?Y2/nZKA7KoVqRBURGT9e+4LOhCKIEDeYB2xIoVExOA2PUTBdLv+wfMpAG4o2?=
 =?us-ascii?Q?RDMLn5tFCAPf73i5hKB1GlL46BN58nf0Z5T0knQunT6G/Kt7fEU5EvPmMMlQ?=
 =?us-ascii?Q?cCsapYFhUtxSYJa1fNz7FvLaoTUBDS2LHQY2mWQDu122u51DYCykPfETaBwC?=
 =?us-ascii?Q?Ghz/WXTOyEdV2wmzxn2B6PnGnkMNGgmTtziJlNnU4QwHVFzx9vb37tPQfUqD?=
 =?us-ascii?Q?c5+mB7rGnSPebycHAYsV0pTUL5ds1+VYFBOBeotkDXtyXjFelrH2xnmwsKEW?=
 =?us-ascii?Q?6+0PLauC6Nlea3mnz6W9rHngPOQhsU8Co6VDpnYwgFv8vb+gHYS46ThIObrv?=
 =?us-ascii?Q?F6ajRmVIZp3i8dBveRZH82k7rMUc6vuNzZv23FrSRMNEDBzfnvXLS6gXQ/Tw?=
 =?us-ascii?Q?2V5X/hArR4nezmiFRkm7dFNVaWOd39WDf8nMZ2c3ZfTXPo+WEEDL53YSLW1R?=
 =?us-ascii?Q?mrcx+KC6bmqHW5pB3ehw4aIsIYuePhyfX5jk1zckwH1GEAKSfGdFgoqzTmmT?=
 =?us-ascii?Q?8Cpuh1sm1m+/hyJEec9eBjhCGc5lLnhRq4SOgJzrtLjSl/q1NcbC9n5akU8H?=
 =?us-ascii?Q?2weMiDeeb/WoBjtjnlda9Mp9AM+hrOl3Hs+PTzz5ACbhrHzBe8JVnO06nF5H?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5904A73B037D21499D7A271B86B716B8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pfIvWozLZZLBFWoKp2MW2Q2VoosrtlWfqsYbdM7RghaTYQXzfmvgk1VnBbjxRSuWDfnyF4IuplNegsR3v1vEOkFZ12Hh5bXSt7CONZsvlKtb94ZobG7j/PyDVjjUfUSzSi/gkkV7Qjos58H3+sdpqXnrfrWiOllOH3Tx7KIIRGE9+geGo3D8FVoYceIEBiWzSLwQukCdvkdG0XYgzUJwY5yaAX7boInUmPZq+ma9J1GKfiaGBRgpnIgs0mFl+3G2mb2j6HngWh7rGZCuOSIHa9gPPXJe4oSNw6nRLrdTGLjA6VOa3icp4KUaLTosC+8m92HTNA08iKrBoZpd+1ByFCsoH/uw84NLA40+U9Swn9A0A2o1+783DBBrZb7EiD3SEAIUQWVG292rjx6/4dib6UUaGD4FHUnSRLew+r+sI9vDPhhamIuX9FwA8GqLaVTSqkygrA9vm/JZsGJWdZgd7ieRkmNHQ383N3zcDIz37/7Rr3RD8KuGRG/H6B5jZWmSh2OcmL6946Nc2E0DN9XeHLfFmkLLxJ0IJ1o0oFo64fHeUFRt95EKXNR1a2+VUCG8INlE8aeN0gMIvpcIetp0TE3lTlVXZPDq2/K42a1H6cJmqXeTN1KbIMF3jFQuO28LaP0VewTE9u+kIqVngzaGq5UkUqtAjqUbW9ymizDKEqL7BCnLrUeY7NMLbAabXTvQsoMnrzMVzDuaMkzbwH3T7oukaP3VUfOA1EMmwbxLgwdIB2pHBxMu1gZ0yyImucLmevNbEtLeU2dCZhmANhJczJ6qVDLfCVLVUp+cO8v3NWs+sHBonySApPgaCZK2wYpc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3de90-fa3b-4c1f-b02d-08dbb329893a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 00:45:17.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbczoCsOkN0+o3yPKNPVwkdCWgN5zCMOHb0DuQyHVniPwtP81hJygCnbAN3kF0/9wDcNHT6x6TJY6PtiZoOYjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120005
X-Proofpoint-ORIG-GUID: ALLTn3XyCxHj_nRIVJT_eEhHs2XuHXd8
X-Proofpoint-GUID: ALLTn3XyCxHj_nRIVJT_eEhHs2XuHXd8
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 11, 2023, at 7:42 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2023-09-11 at 22:10 +0000, Chuck Lever III wrote:
>>=20
>>> On Sep 11, 2023, at 4:54 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Mon, 2023-09-11 at 16:14 -0400, Chuck Lever wrote:
>>>> On Mon, Sep 11, 2023 at 02:43:57PM -0400,
>>>> trondmy@gmail.com wrote:
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> If fsync() is returning EAGAIN, then we can assume that the
>>>>> filesystem
>>>>> being exported is something like NFS with the 'softerr' mount
>>>>> option
>>>>> enabled, and that it is just asking us to replay the fsync()
>>>>> operation
>>>>> at a later date.
>>>>> If we see an ESTALE, then ditto: the file is gone, so there is
>>>>> no
>>>>> danger
>>>>> of losing the error.
>>>>> For those cases, do not reset the write verifier.
>>>>=20
>>>> Out of interest, what's the hazard in a write verifier change in
>>>> these cases? There could be a slight performance penalty, I
>>>> imagine,
>>>> but how frequently does this happen?
>>>=20
>>> When re-exporting to NFSv4 clients, it should be less of a problem,
>>> since any REMOVE will result in a sillyrenamed file that only
>>> disappears once the file is closed. However with NFSv3 clients,
>>> that is
>>> circumvented by the fact that the filecache closes the files when
>>> they
>>> are inactive. We've seen this occur frequently with VMware vmdks:
>>> their
>>> lock files appear to generate a lot of these phantom ESTALE writes.
>>>=20
>>> As for EAGAIN, I just pushed out a 2 patch client series that makes
>>> it
>>> a lot more frequent when re-exporting NFSv4 with 'softerr'.
>>>=20
>>> Finally, it is worth noting that a write verifier change has a
>>> global
>>> effect, causing retransmission by all clients of all uncommitted
>>> unstable writes for all files, so is worth mitigating where
>>> possible.
>>=20
>> Good info. I've added some of this to the patch description.
>>=20
>>=20
>>>> One more below.
>>>>=20
>>>>=20
>>>>> Signed-off-by: Trond Myklebust
>>>>> <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>>  fs/nfsd/vfs.c | 29 +++++++++++++++++++----------
>>>>>  1 file changed, 19 insertions(+), 10 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>> index 98fa4fd0556d..31daf9f63572 100644
>>>>> --- a/fs/nfsd/vfs.c
>>>>> +++ b/fs/nfsd/vfs.c
>>>>> @@ -337,6 +337,20 @@ nfsd_lookup(struct svc_rqst *rqstp, struct
>>>>> svc_fh *fhp, const char *name,
>>>>>         return err;
>>>>>  }
>>>>> =20
>>>>> +static void
>>>>> +commit_reset_write_verifier(struct nfsd_net *nn, struct
>>>>> svc_rqst
>>>>> *rqstp,
>>>>> +                           int err)
>>>>> +{
>>>>> +       switch (err) {
>>>>> +       case -EAGAIN:
>>>>> +       case -ESTALE:
>>>>> +               break;
>>>>> +       default:
>>>>> +               nfsd_reset_write_verifier(nn);
>>>>> +               trace_nfsd_writeverf_reset(nn, rqstp, err);
>>>>> +       }
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * Commit metadata changes to stable storage.
>>>>>   */
>>>>> @@ -647,8 +661,7 @@ __be32 nfsd4_clone_file_range(struct
>>>>> svc_rqst
>>>>> *rqstp,
>>>>>                                       =20
>>>>> &nfsd4_get_cstate(rqstp)-
>>>>>> current_fh,
>>>>>                                         dst_pos,
>>>>>                                         count, status);
>>>>> -                       nfsd_reset_write_verifier(nn);
>>>>> -                       trace_nfsd_writeverf_reset(nn, rqstp,
>>>>> status);
>>>>> +                       commit_reset_write_verifier(nn, rqstp,
>>>>> status);
>>>>>                         ret =3D nfserrno(status);
>>>>>                 }
>>>>>         }
>>>>> @@ -1170,8 +1183,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp,
>>>>> struct
>>>>> svc_fh *fhp, struct nfsd_file *nf,
>>>>>         host_err =3D vfs_iter_write(file, &iter, &pos, flags);
>>>>>         file_end_write(file);
>>>>>         if (host_err < 0) {
>>>>> -               nfsd_reset_write_verifier(nn);
>>>>> -               trace_nfsd_writeverf_reset(nn, rqstp,
>>>>> host_err);
>>>>> +               commit_reset_write_verifier(nn, rqstp,
>>>>> host_err);
>>>>=20
>>>> Can generic_file_write_iter() or its brethren return STALE or
>>>> AGAIN
>>>> before they get to the generic_write_sync() call ?
>>>=20
>>> The call to nfs_revalidate_file_size(), which can occur when you
>>> are
>>> appending to the file (whether or not O_APPEND is set) could indeed
>>> return ESTALE.
>>> With the new patchset mentioned above, it could also return EAGAIN.
>>=20
>> Sounds like I should drop this hunk when applying this fix.
>=20
> I'm not understanding. Why would you not keep it?

generic_file_write_iter() and its brethren are two calls in
one, if I'm following this correctly:

1. write
2. sync

All the other places you change are "sync" only, so it's
fairly obvious that those callers get a return code that
reflects a failure of "sync".

I asked above if it's possible for the "write" part of
generic_file_write_iter() to fail with STALE/AGAIN before the
sync part is even called.

You seemed to be answering "yes, the 'write' part can fail
that way" but I may have misunderstood your response.

If the "write" step can fail, isn't that something that should
be reflected in a write verifier change? If yes, I don't see
how this particular call site can distinguish between a "write"
failure versus a "sync" failure.

Or, if the vfs_iter_write() call here is guaranteed to never
be a sync write request, then again, I think we want to reflect
all failures here with a write verifier change.

However, if STALE and AGAIN have the exact same semantics
for "write" as they do for "sync", those failures can be
thrown away too, and I can keep this hunk. Are you saying
this is the case?

(this is /only/ for the vfs_iter_write() call site. The others
look OK to me).


>>>>>                 goto out_nfserr;
>>>>>         }
>>>>>         *cnt =3D host_err;
>>>>> @@ -1183,10 +1195,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp,
>>>>> struct svc_fh *fhp, struct nfsd_file *nf,
>>>>> =20
>>>>>         if (stable && use_wgather) {
>>>>>                 host_err =3D wait_for_concurrent_writes(file);
>>>>> -               if (host_err < 0) {
>>>>> -                       nfsd_reset_write_verifier(nn);
>>>>> -                       trace_nfsd_writeverf_reset(nn, rqstp,
>>>>> host_err);
>>>>> -               }
>>>>> +               if (host_err < 0)
>>>>> +                       commit_reset_write_verifier(nn, rqstp,
>>>>> host_err);
>>>>>         }
>>>>> =20
>>>>>  out_nfserr:
>>>>> @@ -1329,8 +1339,7 @@ nfsd_commit(struct svc_rqst *rqstp,
>>>>> struct
>>>>> svc_fh *fhp, struct nfsd_file *nf,
>>>>>                         err =3D nfserr_notsupp;
>>>>>                         break;
>>>>>                 default:
>>>>> -                       nfsd_reset_write_verifier(nn);
>>>>> -                       trace_nfsd_writeverf_reset(nn, rqstp,
>>>>> err2);
>>>>> +                       commit_reset_write_verifier(nn, rqstp,
>>>>> err2);
>>>>>                         err =3D nfserrno(err2);
>>>>>                 }
>>>>>         } else
>>>>> --=20
>>>>> 2.41.0
>>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

--
Chuck Lever


