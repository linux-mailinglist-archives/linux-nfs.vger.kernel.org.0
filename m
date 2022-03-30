Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EFD4EC871
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348392AbiC3Pkz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiC3Pkh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 11:40:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E8411A34
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 08:38:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UFL0DC007033;
        Wed, 30 Mar 2022 15:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wfjT+8lwO5Ruc4iDpi4kWyceAzRm1/sVZYN6nfWXPoA=;
 b=Cp4xVq0EHSbOOENwpR42J0eVczKb2F3I9W8WHvoNVa5Ivk3O+h0GQrjUQ1WHRZv9cBye
 o3Cfx9B6VD6p7l6SvsfdNxj5NOk9k6GR6scV4Sqz1aAp7vnuQZRedMMUOcEXnS5DtaBo
 +bZlsX1XFxyVuqeznBP9PsHx8HBqxsj3UlIm3V3gdTeMG9EOmaF/FSKT5BBSgnVXB2OZ
 L6HigoEpSVhiNOsu66hNqW0XRiqqyjIVY9b4VrBQ0nrrIl8z33T+mA/RJTXSwIK8hAgE
 3td/g2cADvjDRPRLWfRcQ16Jwk7U2ZsF4w537yMytJtdtDzALQpgRdPt6u3Dkhstk7MV XA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes1u6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 15:38:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22UFUX4b028834;
        Wed, 30 Mar 2022 15:38:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s949uk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 15:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxtejVV26MMQ23ZJ3b0/MKbGoY9aR/9k2AQ9NEOg13UVvTApw2mcAZV+FnMTHD6zZfFQrv58gUtKTAOGTXNwpB0VMlCx5XrdQrKPndw4r8B6zYrr6HmvHrlTCW/jddfezuoYcLO6iDQhaAle+Drlp+/qXa2RRBnw4m936bZ4mS1RNc3hyJ6CfGxfoVg30eO6xte/NQLu7vWFTc+IbZUPhypKvzifNQQ6sD1EgNSpeM8fYPwImOYeDPUwE0BHKBc0pCWfTMBjl7CzIb1JjRVTHq1QgxN4/vfEk2/o6ssy41g3GMgP1pPtdtOx0+qeBuChIpLGJh1QHyX6xAlOnM8OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfjT+8lwO5Ruc4iDpi4kWyceAzRm1/sVZYN6nfWXPoA=;
 b=dg7QdRXBvfMf5TwSaDy1MdNxNXftNn6MCby0Vz1DhyJLlpOLHyRCY1atjtsLRYGWUod/WMG1wAO66XiL59dU+UMSOke5SFm/jAHilTFu+PQa2gJknzoZvxz3AWkrdifQxfSB/v7vOPeQsEMPHadQ0YreTjBUQ26aJtcfiyMBsUi0Wmb/mhQHiDiLJiIsX8CzYNPW9C/fL4yJiKjmU5ZIeR8Lx91z6Cl9q6cxHw3tUmfDvD+g5WJ3TDFymszWL2PxM6A37W4RlIuRexRdX1qqo0rcOQjqps8OCz61WZlgvLcAI5+u0ntmj/Hq1pVULV7QsvyTJh4s4wyOdGsTCL65Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfjT+8lwO5Ruc4iDpi4kWyceAzRm1/sVZYN6nfWXPoA=;
 b=McFJ3ITFJzqOcd5jfhr+qjzdRkBnedJ1obojWsOxQhI5afA0CPyQzpKruFQ4vh79BcLWPQhchlZZSR+lhplgplZUj3PbvaPYqZZBrlPbrmQdknel/ho/MWerVoNhjdNim+wYY1JTg8ibV8heXtBJI5jD9HvBkiuiMuqXvJ9TWMo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2450.namprd10.prod.outlook.com (2603:10b6:406:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 15:38:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.020; Wed, 30 Mar 2022
 15:38:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "jack@suse.cz" <jack@suse.cz>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: Performance regression with random IO pattern from the client
Thread-Topic: Performance regression with random IO pattern from the client
Thread-Index: AQHYRCHUc6q/mRhCvEKbVzqr4c88IqzYBl4AgAAJ0IA=
Date:   Wed, 30 Mar 2022 15:38:38 +0000
Message-ID: <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
 <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
In-Reply-To: <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29961c13-c18a-49b7-16e2-08da12635c0b
x-ms-traffictypediagnostic: BN7PR10MB2450:EE_
x-microsoft-antispam-prvs: <BN7PR10MB24506B90B7102A209BB18B5E931F9@BN7PR10MB2450.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BSuHHRjf0yyvcm6OPvzrZ8rdZfIqPDi8Xf9BPUsZ1m5eTNMQL6LxKoUxaCc8VGr94HFWD42F7chkccP6p0UVFTXXjNFhFIZ7weaY8RG/0xg/UVrOpLOz84dw8xD4e+0YjXshnKVYN7wlznuQpZn+CnScJhjnGlmBUOJoleQmiuQM5WTiD+gPQAeuokCDvM9LM6a0asjE3NxVnJTfH6SkpGwCR00hDps8PgEHHnq4Y5CMjuwu9Qk9iIPWxS9INDHQoXhmatXbycce1qqPXyv+mnWMYAz4/yKS54TRGrwoQI138rXAhTYRO+TRgRyml3YLb/lrJkTCAPmXhNxP4tD6KbfB8dNaWdPmZ57B/JLsRYQ6uQllUvrO9kc3SN6aI0os/Cr3JAD09FyeWYyxbj7NAGmdDKi9iZayFVirIJGlU9wPwxIUksogIUf7mMpbjsgpHMlqpSU6diOj4PEsMeoyWj9Tf7fdT1eQYJz0P7S6opX0F8XCoqX/50lHxpEdEbXVM69g15DRIlTi6INPTFnBLPjL4EHy8S69mnRnWSYQB0dH+t9DgHPjzQnsUVA3nPoZDlASSqtxRxkQysPOkUx5f//aoA5uxc4hEM4zGPTyAJ1duRsrmYUZEBzPaXcZ2Y6YcWtx5qgMSiwoV5SPxu1KW/II3B+zbFuM29Lg0Uj5d1GRIbUoQTNi5fzwsrLw3RjIQho6x/kpwqmafl7XUhsE4zvenj/yBLY8rT2bmBZV3uQS4SyJeurFz5Tqmqe4NPSP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(71200400001)(91956017)(66556008)(66446008)(76116006)(66946007)(64756008)(8676002)(4326008)(6486002)(6512007)(66476007)(83380400001)(33656002)(36756003)(53546011)(508600001)(19627235002)(6506007)(26005)(186003)(54906003)(2906002)(5660300002)(2616005)(38100700002)(110136005)(122000001)(8936002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z2kLBnpsDfT3pgukwGAO55nP5R27OzoH5VV1uTxfa4IetHYW5D7qy2O/ZuR4?=
 =?us-ascii?Q?I5y59TK6O7h2BRXUwyu12RboH6tFb9S866vzgWubg10+NstJluG7LTmGpFeC?=
 =?us-ascii?Q?0jwDa2GUS0aAPxm067kktXFKIwb/amxkShrCKz8P6Z1O9Nfllp+MlVDk9+Jr?=
 =?us-ascii?Q?QkrDbB3YCsibBStq1xKROF5x5xSdoxY+QIuqLgLwQnfYciodIUEdsW/pSFUf?=
 =?us-ascii?Q?qrSufaneDDVv8yjs+HB0eOZ+ninEyjWOFe6ImyBL7V/dZ2UeRA+B5oQdedWx?=
 =?us-ascii?Q?xuuNXRZMAgrmYQ7HGfzVL1OG31hRLfXdYRs+oC9wGmOHNGY7qUTB1qAjh5Pp?=
 =?us-ascii?Q?HL5LV2gOpm+jV5E2p1e2/Y0ozRLDTpqBZv+x+858bnDyfJY0JqZlYWDymuNr?=
 =?us-ascii?Q?+Eb2rhHKwZr/EYF3pDgHz63mtuMTo/BYwGhiCLCSBR+VKTiqppSNf20dVFL2?=
 =?us-ascii?Q?xwA5Q0ID1f4SeSBPDvczDEWsnn/HqU0eYm8ql3Iw8BnUGEvgfhOdRdKzPNnd?=
 =?us-ascii?Q?KP1WMTU2GlGtdU6/v21xFjFuzyxCT5ghs3EmeUX3kkSQPnMsV30gL6T3zSzX?=
 =?us-ascii?Q?gT/l/k2gQz57igjCvTOmqb/WBdoP3JDKT8RUZR1Sr0bVo9ZRMYATgovfSSGD?=
 =?us-ascii?Q?kqH3lG5MqiXm8VASxffgVpQeGnPc1sL7aILWnAB4IlJXpNmCNa6gm7lHcxzy?=
 =?us-ascii?Q?GAxtwG40j4zWaf85a6A/Ldenq68VK5TgV4V0GwdfP5Y75BdDLfnD2pR1Ks76?=
 =?us-ascii?Q?dzSFn8yew39zTG8iRdiRmLAXJGj2et/BGLcG+0BVp45o17Yw4rg1yKBTAo70?=
 =?us-ascii?Q?ZY7VeSa0V34FiK1KwHa4BaTQ3QFmi2TjSM2CN6PeKJnp0O9mpdAYR6Tej4Ne?=
 =?us-ascii?Q?bOYOCfxxmsBBCCruY2usQbNee4pH0BrLrOIcWJLbQy6BzFfytf9aUF5jk3Pq?=
 =?us-ascii?Q?kc2T4DYEwr7nKjbYVB4HqTkkm3IavPJLXDKcJVo18iNgzh5PO/BWzD+nl+67?=
 =?us-ascii?Q?0xJqlozX7bhFJxgbxdyJslETE7vBFREZa299XDk3eT79hcnpvD2B4q0/ZLQM?=
 =?us-ascii?Q?+tSbT3wuTImaB+I4jRDhisIXq9lRUxd86u10Sed3QWLepM+7s/Q2rgkIIF0F?=
 =?us-ascii?Q?foTBoi+n/ujzkkbYZzfKrHMJKpBPTd4a7Xb6GzFeQxx/EF2Z8ifA4VnY7S6G?=
 =?us-ascii?Q?jqzK6/LZs80OeLz+wl7xhv1yN1ku7EKVohCu5mouNhdl7dpc4eoZhOYd5dpi?=
 =?us-ascii?Q?KifZ5NHBGPhveJ5RJqiKgrq7pshoTWD74QhVuBCIeL5pcPjPBQEmAaMTaYN2?=
 =?us-ascii?Q?5jm91u71VRuE5nZb90UBPRIpifi9UBhKpZZBX4v+LMBZyE3Zcjnqq5OJTpgO?=
 =?us-ascii?Q?8aVUx6SJZKSmJUncirWI5kV4c6jDBvKxTRcgjspwQYB5CjQXy/Yw9z8zp5S+?=
 =?us-ascii?Q?qx2l7barV3xNJMnMyrMkwINECU9WPW6Z9NoD4FTBKL5JQRcj7YrbTsHT/+Sg?=
 =?us-ascii?Q?lLSVt9SwTich67tYng9lN8TpMCBWhkSL0HUzVWW95iXZnPMdWr0FVbTslJFd?=
 =?us-ascii?Q?zuh1r3t7k4eWTG3xIs6N2EfvtN8j0T7XH1M1taJq87QRIRfe3Dvoq2BYOCuj?=
 =?us-ascii?Q?IGIixALNS1k/TAwzETOOMH/wyomR2IxeYGhjBDmMgDC8RgPXSeiI1VrzCn+D?=
 =?us-ascii?Q?icjntrpQvuzZHG7PGeVUp3KcVA+tjUEPLqysLaIFTXheKVOaYCkK+U7vslXq?=
 =?us-ascii?Q?FV+ZFrNjGxqB4agW1LryMrG509n/GtU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F1D3F699C253646988759B4AFB722B4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29961c13-c18a-49b7-16e2-08da12635c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 15:38:38.0702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqfZUsLSzGQta7Hk4NjoC+rRKNA21k0nbx0YEvpRAOts54YKWcAC0VCjwfNyI8rq3MFMhP757gItuMj+21jBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2450
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-30_04:2022-03-29,2022-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300075
X-Proofpoint-GUID: UGRvAzTvDNPyzUXhcuPLw3ADjUEZXbCG
X-Proofpoint-ORIG-GUID: UGRvAzTvDNPyzUXhcuPLw3ADjUEZXbCG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 30, 2022, at 11:03 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Wed, 2022-03-30 at 12:34 +0200, Jan Kara wrote:
>> Hello,
>>=20
>> during our performance testing we have noticed that commit
>> b6669305d35a
>> ("nfsd: Reduce the number of calls to nfsd_file_gc()") has introduced
>> a
>> performance regression when a client does random buffered writes. The
>> workload on NFS client is fio running 4 processed doing random
>> buffered writes to 4
>> different files and the files are large enough to hit dirty limits
>> and
>> force writeback from the client. In particular the invocation is
>> like:
>>=20
>> fio --direct=3D0 --ioengine=3Dsync --thread --directory=3D/mnt/mnt1 --
>> invalidate=3D1 --group_reporting=3D1 --runtime=3D300 --fallocate=3Dposix=
 --
>> ramp_time=3D10 --name=3DRandomReads-128000-4k-4 --new_group --
>> rw=3Drandwrite --size=3D4000m --numjobs=3D4 --bs=3D4k --
>> filename_format=3DFioWorkloads.\$jobnum --end_fsync=3D1
>>=20
>> The reason why commit b6669305d35a regresses performance is the
>> filemap_flush() call it adds into nfsd_file_put(). Before this commit
>> writeback on the server happened from nfsd_commit() code resulting in
>> rather long semisequential streams of 4k writes. After commit
>> b6669305d35a
>> all the writeback happens from filemap_flush() calls resulting in
>> much
>> longer average seek distance (IO from different files is more
>> interleaved)
>> and about 16-20% regression in the achieved writeback throughput when
>> the
>> backing store is rotational storage.
>>=20
>> I think the filemap_flush() from nfsd_file_put() is indeed rather
>> aggressive and I think we'd be better off to just leave writeback to
>> either
>> nfsd_commit() or standard dirty page cleaning happening on the
>> system. I
>> assume the rationale for the filemap_flush() call was to make it more
>> likely the file can be evicted during the garbage collection run? Was
>> there
>> any particular problem leading to addition of this call or was it
>> just "it
>> seemed like a good idea" thing?
>>=20
>> Thanks in advance for ideas.
>>=20
>>                                                                 Honza
>=20
> It was mainly introduced to reduce the amount of work that
> nfsd_file_free() needs to do. In particular when re-exporting NFS, the
> call to filp_close() can be expensive because it synchronously flushes
> out dirty pages. That again means that some of the calls to
> nfsd_file_dispose_list() can end up being very expensive (particularly
> the ones run by the garbage collector itself).

The "no regressions" rule suggests that some kind of action needs
to be taken. I don't have a sense of whether Jan's workload or NFS
re-export is the more common use case, however.

I can see that filp_close() on a file on an NFS mount could be
costly if that file has dirty pages, due to the NFS client's
"flush on close" semantic.

Trond, are there alternatives to flushing in the nfsd_file_put()
path? I'm willing to entertain bug fix patches rather than a
mechanical revert of b6669305d35a.


--
Chuck Lever



