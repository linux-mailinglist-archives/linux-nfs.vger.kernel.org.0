Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACDA611B35
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJ1Tuv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJ1Tut (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 15:50:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307215F934
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 12:50:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIxSt1004085;
        Fri, 28 Oct 2022 19:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vKrCZ3EzTlfwfvrCkTA5gLLst+DeFrDjTlhPTak56fI=;
 b=k0MoBgHtMkxMEEliMnPLxVHc4kgF9qZDWjv3r9+nxXFAMZ+zYb5grUHlO5OnGL4zG/qJ
 OBkUbVVKMpMTTxBRlqbAJTGjAS2qYkIXxW0y/wTLb3g+0WTwAUDoCUS1cjABvGaxQYsR
 jsUuS7snKoOGCpM4M8csZYT7ChT91mDRcn98/FD1hSLppWgQaeLvQ1vVkxSF7Km3aoiZ
 esemLdRP1VHud/yrFxDdkQjS3XNukn6ArKO8zgUbS48/GH0yk5iMJ+mDTGjJIyCdlxjS
 S+C4kpdopZ6/T4q8nqO12QBSHY+CkXlVzW+SMyWYkse6vJn5DW0tqe8fwLiBkHpXKfPF 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0any14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:50:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SGrv3a026525;
        Fri, 28 Oct 2022 19:50:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagre521-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh69Q/rUSYnqd9jKKygtkqlVv+/+V1ZLq3rYJTEpGHInkDuKmnAd89OR7gj/mQX03UAk/OJ4ufNRlx66XcblileG0y9NZEVy7ft7RifZo6hFtWjAKZMsh2ZQwbVTy/OvosGA8pgL6JDvYNsfvu2C7Ei7iZiwX37IvxAz5SVKs/rVwx8M3B8kU5+UZFCcKWuHSsLjuyANURfunWF9pv+0RmiavPDImljxBO6PuFdQ2TN+DqrT5uzCgehuRbpRiXQf7Tv4Et41L6u2wK8MOYA69sVKI/eCrnZUq8VRC8W9hE4vPAeDNR050hqlg2oaDDukXd5HxOxD23GEhagukZKXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKrCZ3EzTlfwfvrCkTA5gLLst+DeFrDjTlhPTak56fI=;
 b=MStdu7UKj2qEadd4zHsYPS6OJKmg/RioDvNsGLNsQf4cUKpVuJ3br3DPgDe6mBnG0cJWQW4+WTUUvroe9Mn/jqHMOmmWRh7ucNNPCluyiEHe+LjchKtIyjksXmBKs0w0gVm36hmMBTWo0EFUW1LGy+DmEz6GOqOI9ytfyX45/yFHDewHlpzbIPyhbcwVmrcHrJJ3/+I6ViHPNwTX7t5fxmhU4WQ/b1zq3H7GShpXv7q5NbEl3TcAlT3DUErpjWoRWvVFO3olynf2X/gWZV4c18z2Gf5J2tGeOdmhNyB0bircI4tlT6aMGheZ8uBGDrMe18Cws46+a+nijCBzMz9CuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKrCZ3EzTlfwfvrCkTA5gLLst+DeFrDjTlhPTak56fI=;
 b=EICwwW/KS84A9jeL5n+3QdZiwYrhSkgLrCDi72kcgFX+7jUZD7BWF2LudnGaI+r0z2vSGcSj1YYaZXcYu9J1Dkitt/+BH5/XbdPvqNazzubohKBxnb32GS/yNS63C+AyIZ8tdrhHlT+wcKwVSHA5QYvxTXforaU/PkKOjmVYqm4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:50:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 19:50:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 4/4] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Topic: [PATCH v3 4/4] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Index: AQHY6v8cX8B2IAnCiUGFnEk+Gt8JNK4kNxkA
Date:   Fri, 28 Oct 2022 19:50:39 +0000
Message-ID: <89288CA4-F679-482C-B9D1-68C583D7F5BA@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-5-jlayton@kernel.org>
In-Reply-To: <20221028185712.79863-5-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6086:EE_
x-ms-office365-filtering-correlation-id: 3627d9c0-ea25-4669-2391-08dab91db072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFsU+HkUY1WlFHfj073qldO4RF9rNMBS3yHNudhZoK3NYiaoyNleqSV2KmO/zTw7KgouBMqxVbBXN+DRqiZFUCl8H7w7UeEBvi8LVymaS5s9d+2EG/3QiIdT0W7bietOc1kDLt0JxZG2HXdSX9a3BmVNapMQWKuYxQiRG17uO7QISVUwSVv3NFui/qiMwK2nHMIrANxRmsOKsldtFg7DOM6RvcVYqU1QJ9exa82JyOm5zbwFj+1ywglLY9JLN1u9L90e10DKUl+dbiAbcr5xEIWkQNULLWDgQQ7bIPI1M1ShXJhmRJUuOKtzKuvZ4yj6QlezYn11i2POit+sDC0SUhtJjUOgzj5R7CArS/c58wi9aCHAyDLITbh4zA3GLAlHUXXCNPwIwGEmzY/ZhYsiP/aOXzYk/jzEFOFIE8A4yjMK8WIFzCiOF06dmbqwPNWF0Ow/R2NuOHHkAHBkQvmo2Q1haMj1Tf7ZNZwcIVH+JxTD6IrTk2SURedQ9I2qSRmNL0dwgQ4DjuW2qmntDP+rtT0WIMiXHwbEYIwZOUhw4oZgIvSv7PiHmQkunGN9wr7yhIuzoFp7vAp4wdDhHXMYEQIKtJQbYlu03hniCXkcuGwUK7bx/ULdLNZ/9SC7jZM6rE/RGUX1TzpviRcMRuTwvhHLz6O467m1ThF+pBWHpNX+Teogi7fC06PSUPRab66T+lRth0YEn1H5VuxkVevVNQhsPHg4T/XOvcen6WJ3Lr4WxYyb1FDrVQUaA55ViSqbbrmp7gvpyQWsEIfHz4ZWq27Z/nHghHpHeid0/0/HSf0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(316002)(54906003)(6916009)(33656002)(8936002)(41300700001)(71200400001)(38070700005)(76116006)(8676002)(5660300002)(4326008)(91956017)(66476007)(38100700002)(66556008)(64756008)(122000001)(66446008)(53546011)(6506007)(86362001)(26005)(6512007)(66946007)(478600001)(2616005)(186003)(83380400001)(6486002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kms5VAXmYeU6T4iczibeA6r9Os/Mus3jp4BHZ3y7sDR2O8dvysnjlbKztn6J?=
 =?us-ascii?Q?90uCyobjFHqDp4FWWDLy3YTsrnR5w4FEDfMz9AVT9ZCRJKRMTFM8jvO1Awbh?=
 =?us-ascii?Q?pGvFX36bs2bC2FkE8kWiDXtuiDn7XszOLaz+Dxw8lgFfAcbODjhxuggYlByy?=
 =?us-ascii?Q?0n+JqeNsLTA1cxjyiW1KILWe/cm3Jq5zIpAbv0iOXtkLn40CQUX7GIbGoUmd?=
 =?us-ascii?Q?EpG7RDIW7lYy9v1U1eQ/f5vU9zDhkOqR6eevngIVkhI9SK+bN0Ryff7ZL60c?=
 =?us-ascii?Q?i9JsXaDZfxy+68H45oZHpU2BjRSvqgxozhW/ijBcPETJ8jGA5hXpi3woFhzx?=
 =?us-ascii?Q?UGphjGfaAi6QQGptNOE8+XQj/pbXfHiwwXbEkMcOd5vQcHgPXj7kxZe6W8Kn?=
 =?us-ascii?Q?9qL22lmi+LUrniGmNy83eAGeCJJpMQLpbIuKt6y7CSsatbQ44ocz/Tek/0NQ?=
 =?us-ascii?Q?/4/yWwn2yPB15tpw9XkqXsy2ktAl8auLTT6ncX8We2uo0VJYLHJI6xSUm5b/?=
 =?us-ascii?Q?t+OT0fDtc4TNYKBFSOKITJYpdiRJpqZhmHkzmce0XD8Dcd4nKQoZ2y1u8BZF?=
 =?us-ascii?Q?GewJqawR3HnrnQXZIaLJpYNRhThSrUi3OGQfjfiNLJ+V4qPoV6wj1/sxkkCZ?=
 =?us-ascii?Q?HKJCZ0Chmd3hgpUGK7SG1WBizCE7pUnDfMFt4jHGtOZSRgboEEESGo17eqvL?=
 =?us-ascii?Q?AR7vN//BS6z9j7m/EOSLReJaJjNI4J9FL26IGXJp8y9MRGjG7ddn8d0ZV93/?=
 =?us-ascii?Q?xW1xbWuJOXE/1Ce8OrR6ufw5jV8tb7Fg3a7d4rqrSivr4E4WObg5p52tsRnb?=
 =?us-ascii?Q?E5rSmMI2KENG+BaFoBucMIOQNHPvYnoi07Au1nfem0/2+08+uiXCMaoE43VD?=
 =?us-ascii?Q?v1RgP2fbup+DIBLm9Pr0l675tBeQjjuA+ff1TCDvQdGumVDjlALVPhUbNsg8?=
 =?us-ascii?Q?OM5sJcWejdrkXRJQk1uUZvwGmJIwHpLKAKiRTMfmjjAES52UB2rd0DTMg9xY?=
 =?us-ascii?Q?3Hii4egkqunQaQwUf6dk8puz3r8K7buyzypTVlUNqfuSH3QrOHWCyXAj94CQ?=
 =?us-ascii?Q?zYdTg6qaPek1ZisN956a05xBK1xDAn+g/oBQuTEGtJFOjbBCnJJfXSpGfSw5?=
 =?us-ascii?Q?zHnbKS5/FYFeP3VT4zBo1TxJEIozwvVuc5eX/A6K/aFJDRpaNbHb3Jyq1Tz0?=
 =?us-ascii?Q?XqBaj+U8tsOP7i01sKbzd3UrLspO8o7OiD5V1lDAGPBHFzCE0id1wvLKfJVp?=
 =?us-ascii?Q?agWM97luCkbipozvIASipXzBY5pCqxmn+RVDaiw3HWr8VxcVjH7SFW+Z8O0l?=
 =?us-ascii?Q?FvubzkE1UR+KatoD27tpkE8YKCBoKLw5DkTeDBdpNriCE2rWOMLLt16nRPAT?=
 =?us-ascii?Q?Tpar6eY/owobiblWKUw2quBOdIVlD7nlbpeqhm7B95H67Uxq2HkTPki6j17M?=
 =?us-ascii?Q?LJhzFBNRB6dN4ktZt6rXg2UO+jqd0pAJTmoaLhm4xBQ5PpDcwUKcHHNcxgr+?=
 =?us-ascii?Q?wrnNmB12sm5ANN//m6Uh2lWWHXqwSfMAruYyPFlri3UiQzqu/HZFw7zsqRWZ?=
 =?us-ascii?Q?Di5Mv/A4TbBLWG25xovhyKVt+fjI+89JugG210x5Tvcn4XRz3zgdDiKoGNYI?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80B87AD551CACA4186DEDA7177D8B5DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3627d9c0-ea25-4669-2391-08dab91db072
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 19:50:39.1494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUARP2SlLjgoNp1Nhy4f+bvykrlzP3fH4nb844LKLEJZEnP+GSqxD8clNbvDzDKhA4moooqhEnR8ZYKL4qcx6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280125
X-Proofpoint-GUID: fECJvLCzGitM74MkDcHk07GXn-beschX
X-Proofpoint-ORIG-GUID: fECJvLCzGitM74MkDcHk07GXn-beschX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> so that we can be ready to close it when the time comes. This should
> help minimize delays when freeing objects reaped from the LRU.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 23 +++++++++++++++++++++--
> 1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 47cdc6129a7b..c43b6cff03e2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -325,6 +325,20 @@ nfsd_file_fsync(struct nfsd_file *nf)
> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
>=20
> +static void
> +nfsd_file_flush(struct nfsd_file *nf)
> +{
> +	struct file *file =3D nf->nf_file;
> +	struct address_space *mapping;
> +
> +	if (!file || !(file->f_mode & FMODE_WRITE))
> +		return;
> +
> +	mapping =3D file->f_mapping;
> +	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> +		filemap_flush(mapping);
> +}
> +
> static int
> nfsd_file_check_write_error(struct nfsd_file *nf)
> {
> @@ -484,9 +498,14 @@ nfsd_file_put(struct nfsd_file *nf)
>=20
> 		/* Try to add it to the LRU.  If that fails, decrement. */
> 		if (nfsd_file_lru_add(nf)) {
> -			/* If it's still hashed, we're done */
> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> +			/*
> +			 * If it's still hashed, we can just return now,
> +			 * after kicking off SYNC_NONE writeback.
> +			 */
> +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +				nfsd_file_flush(nf);
> 				return;
> +			}

nfsd_write() calls nfsd_file_put() after every nfsd_vfs_write(). In some
cases, this new logic adds an async flush after every UNSTABLE NFSv3 WRITE.

I'll need to see performance measurements demonstrating no negative
impact on throughput or latency of NFSv3 WRITEs with large payloads.


> 			/*
> 			 * We're racing with unhashing, so try to remove it from
> --=20
> 2.37.3
>=20

--
Chuck Lever



