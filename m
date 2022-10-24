Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF25060BC4B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 23:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiJXVgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 17:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiJXVgH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 17:36:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884892DF447
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 12:43:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFuIkQ023588;
        Mon, 24 Oct 2022 16:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8ntyl7zeARWCG4Jbg0/HvnjdmnqimZeWK1ywBp/XFXc=;
 b=vknMsj+ESErJeHqFT3LI0+mFTBKsCVO8vCqvZc1slzqFpGDgujMmswfxIfsUmi7gFtzJ
 8r5TZkK5wogX1eMftIFsNcsUKMlYWBs+m8Jm3BbCR4meXkaExYcAFJUsg1vvz63R/8NL
 CP25pJHNObRpGN/Hn8p6Eu6AvaHUy25Wwc0paGXfsg3EShmvXuUv+Y1Vt0vOG5I6yNrl
 SynMAWXAvKeVT055UCoeRdCw2+mY6kUXYAABWWV5X70cHdLBE75+wMIcXPdXsExJTl3j
 0yWfyb88++6Yz1pOfzOvjiiRgdHvgKq6awXuB1wp4VkLvNyfrwrrqOovg4G3DDp1Q9IU GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc9394kfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 16:56:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGntCT039829;
        Mon, 24 Oct 2022 16:56:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9syaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 16:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gokb1/AYeedxfe1xPMIDMkRmKLappJD2nJ65yBupQAgMHDTLo6n+OnubU8QWAWBAw/Gw+NMU9ZLUGu00o620O8xlQeVuVUEBYM/t8ZWgUIJveEk8Ap0HQKui15QVDy+dIsUPupcM2s61fHSO3ZDzcJghRpp5BS/1Mw+FEWiN5QekQieIF4xh65jl9DQvSXca7gYw/W+zFAthRle2jWsZfmPgI4xk/Cjs+1ie87UdxMxy6G6NPsf3JRHN4btQmkcDtoRKgdePq6hTCWxW2XkX2OXQDcRcZ01gd75p2p+Y8w/cclK45Q5aIWvIapF0s3X3HHdI05S/MyUNA9U/tHcgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ntyl7zeARWCG4Jbg0/HvnjdmnqimZeWK1ywBp/XFXc=;
 b=JpnMfXPTJCjlz8drRGMWiUiuKr77+nzbnxHZSiQU4U3/IuejRpl09TnztEUwwbTzqf60IVlUCfkD1m5QTQXO2uzlpHQQqRESjgxFBagbkY7TgPrS7ZfOJfbjPR23o5OOAJsklT2WnYvzY4IJRWlzGeWVmzmjjAMIMn9t+MshUDT0kTOGlydUcXCWVYWINBEVz+cPySE/S9kC8B0K+Wd58INCgFHxZuwkH4lNb5/V0YY+nKVfnwV/0lcYchLAmja1Qm/fcEqssvGTxLSxl0Jp7EbxBVKOQKW+kJxcwFX/QqDAx5+xgv2gssxvsrBz4oCVQsJiOpYkuBdEXwdIjYHZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ntyl7zeARWCG4Jbg0/HvnjdmnqimZeWK1ywBp/XFXc=;
 b=YtFkIYNGxhm52nVcbUYCCadsEKXrTB8zslpacTjj67PsDulYyH1RACumzAJZVkBLun52FYAH0KQEBoiP45GVDlZ1hqZjS40ZEHLt983MRjCtsHEp8Eg1ntiOAxhOWl+s5qOAPClDSNCNnvxn5zHWRKOJHhYso0wMxfQgKYjCNjk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 16:56:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 16:56:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Topic: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Index: AQHY5kFu1afwEzLcEkq5CCpU1lPbEa4deH2AgABOEIA=
Date:   Mon, 24 Oct 2022 16:56:17 +0000
Message-ID: <0DF26ACC-0D67-46D7-A213-40B00AECB138@oracle.com>
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
 <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
 <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
In-Reply-To: <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6822:EE_
x-ms-office365-filtering-correlation-id: 0a743306-ff3c-448d-3e91-08dab5e0ab56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aqMSXpRGSSsopKnU6UfnSv+t2HkGI/b6ixPYZFyDMlUxGpL3+MkcFTbyLBeLyzPVV+/btZtMd3SnnYYITsb/+8eW1M8o7Y7dWwzx92Yafft0OGf36x2tLZ2q/4VJwV1xHcTvFMA/qPvUZzxz5Qk1wV3pv+2e8u/BK/wXbiubxSe9q7zWKVwjZ4ancnW1N+Ht0+Cj1Wi9cmYJwynsoMjCBckwndBt5eptfDj540kQtCDbxqhocq+xNJBnaNU+GjvPncRzy/fvemKltVA8+h186e/3UN7KInLALkDrO2rVeDInaW7pSUhV6mhcNrKrbFIR9Hn/593uaXzyhWQlnYlfmt4rpKFtZ0Pz0nDct31IJc4Rlmkllt1w7kMFQ3AAYTkGkBzQh805nuqpnWkxIIu/cX+JwrahwOt8syuRL93DsZv02ItM+KNLcj6U26H+yNuvO0NHbLgxovxzLZgsCPZefpgOLLnDlIOgBOMECZ5DpMbc/2InDyyI7CZdt+PbHHNHVZpcHakpwvOtDuE5v4WcVNMthoQOX9NF7bmyFYD/yYcGgTl3Z0kUSit4J7cgUF4qXx54v+xivG9+HNNZV6YqZLN1rELlTp/28mwVqfwLFBP0dXqdGSN7rXd0RJ4sWvuacQWIsHNoBWnAeVyxmHs08lA9qKCAz0DXI6ViMMUUnLRR/Ozb+Xb234g9TlJNaTrUMqaGkfkfSOhHu0Qad2HLrXgcKCBtRvOKVOLE5h0z98P2l7b5qIrGA8ZPZOZXb6Ft1wwO+S8KgwlTJbscpUlxmQpnpnLgeERRNS/9VF5UN1w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(2616005)(66476007)(66446008)(66556008)(66946007)(64756008)(5660300002)(53546011)(186003)(6506007)(76116006)(83380400001)(36756003)(91956017)(4326008)(6486002)(478600001)(33656002)(8676002)(4001150100001)(71200400001)(41300700001)(38100700002)(6916009)(86362001)(8936002)(122000001)(2906002)(54906003)(38070700005)(26005)(6512007)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWN0Z0ai0JuprOY1loMEUfNXhsvClpI74wDDog7e4zkAagn14XWVLOy0GI19?=
 =?us-ascii?Q?u0BBHXkdWWhsOzFIRigrAXhEV5M6UH9hJ1+Py82ZuPJnqQqSj9L/SSC62GdK?=
 =?us-ascii?Q?AXjUoUt0WvamJcxmkj5Un8uWD/IIY5QHCIqZ794WyBt7Jtb/gZLmKwdf8GB1?=
 =?us-ascii?Q?kPKTdQLYb+ScSe4wZVqHjhgkWQ+lifBKsnUHce6Vs/xtfry5S7BdhCrScIU+?=
 =?us-ascii?Q?wd8hO2wJgO/aGpeA0aN+HTo17CP2srUibt0cilRNWzmc+HIIVwyqC7uRB9e+?=
 =?us-ascii?Q?yQVeilF5e67xosRdlOuleooPoapl8JWMyPcYCv0JqwS2DUTdm/2eo7JWIXUA?=
 =?us-ascii?Q?NEoftqCM9mqjWDhRfmKsAmI3Q4OwvVPMIKFz/g3cpPHjdOzCs1gNvVrTZo6l?=
 =?us-ascii?Q?wUcc9qtI/VevpZy5jDVXfu1BRR3VApOBEUTT4L+4G/NUPoYiq02HzuoJRgGM?=
 =?us-ascii?Q?XbhcXP84YT9bSSA6ey+rYnmJfVDxCgA6h9a6m4DaSVvBK9zF7FzZbsb6f0up?=
 =?us-ascii?Q?t/5PMvRhZcHskJlsDsbBFZslm9MUfjcmCtg29S0i08KCoLbBCxgUgVxTcV1Y?=
 =?us-ascii?Q?Gsj+kOVw/5IfTxpKk0kwhxSMYzBf/WjB42Dg2GmwrQvkga8VZUwBoxnGeMeC?=
 =?us-ascii?Q?6QJiXLBgDV403aHlZRKIeiMGYveVd+ATLmlVOXiLXutcKJsP7AQgQSW3ef3k?=
 =?us-ascii?Q?lZ8H14XVEbH0UrUhspjbO2ypyPXmOIwVbKP9BBrcLbn1F0bLh1E2irANLvjt?=
 =?us-ascii?Q?02vzm3BeR2wF9ePpseyR+HO6JHiCZ/89TKSahUNhsMMK0UwW/zvheNXSSBcD?=
 =?us-ascii?Q?+nZetL6EL+7+fEu0T+YCB3Lv/kbmvrhL9Scwh13JR3az+FtlTbopIScohbvM?=
 =?us-ascii?Q?ldN/4Wp4pZHY50BO82scH1sQj4D9w9ZzPyq5mL5xysbTbt3Dnrg8yFVmEGUW?=
 =?us-ascii?Q?8Fg4aHTwaHfCWWIhtYFHc6VrT9NloUmjgM5a/l2gQn8HyC59/GxzF/Zkb6e0?=
 =?us-ascii?Q?uuQMSiC9QuYaHAKKjD3Rpa3bQrQn0vsEm7UtOsqJ6UkIz7lLMm8qLC3dujbh?=
 =?us-ascii?Q?W5rrqm4gQIRqt37rNO3GS7pHlSVBrxCD0acgspoYAN414IK3zQmwe5C0HT65?=
 =?us-ascii?Q?TSNYxVn4OOVn5pfioJp0bvZdulQ1f5SjB6yZ4XKgl37u99wOP/8BJYXpuaii?=
 =?us-ascii?Q?2H3tMK0wx+YSPnvUaAQaR9iHlgZCXGlSrgicXG/fZcznlaSY5Q/7X+mIYp04?=
 =?us-ascii?Q?xOyaRrF2u5IKqEFjUVcuTa310mdz/0hjjs8Ajp5IWT1rtsSFvXmqbDlzpQYv?=
 =?us-ascii?Q?y2wnjVlFtJcIiec0sJsBbW6s/yQRnx/HhvDPOv0oPIx7w2B2brZVNZatP4S3?=
 =?us-ascii?Q?q3p+MNepIKZl2r9PYr3tUxUagyXl5iB92UJ9/vL8kgxn8QEudTADT86cNmY7?=
 =?us-ascii?Q?kFQbZQwSFUV7I3+Nx7mid7ggqrS70Y0ysl1GhY6wo+8Whnxw03FZO5mK5Uye?=
 =?us-ascii?Q?HiCxpol3ixAWT/meacjfO75PClOYZ9fVA0zaRQCfYOFP7pdMCn3vPWjm75Zj?=
 =?us-ascii?Q?Xc7K1iAuWgcFRj8k8SOsfeb9bD4Pu9lvX4BvDRpQpf05ECS685AsOoaI/iSo?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AECA3F7BCFAD564CB694320F23A703EC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a743306-ff3c-448d-3e91-08dab5e0ab56
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 16:56:17.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UA6La/Oi5toUhZbfsVVitHrCw2ILd+4fWCYxs4Py6AwyOc/aTJgI4a56/IHcxaLcF3TWQV83VcDnR0oGdXNWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240103
X-Proofpoint-GUID: V2JLmKgJYlF41VFNNs4_cHS6IqYL9EhV
X-Proofpoint-ORIG-GUID: V2JLmKgJYlF41VFNNs4_cHS6IqYL9EhV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 8:16 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
>> There is only one nfsd4_callback, cl_recall_any, added for each
>> nfs4_client. Access to it must be serialized. For now it's done
>> by the cl_recall_any_busy flag since it's used only by the
>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>> then a spinlock must be used.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>> fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>> fs/nfsd/state.h        |  8 +++++++
>> fs/nfsd/xdr4cb.h       |  6 +++++
>> 4 files changed, 105 insertions(+)
>>=20
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index f0e69edf5f0f..03587e1397f4 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream=
 *xdr,
>> }
>>=20
>> /*
>> + * CB_RECALLANY4args
>> + *
>> + *	struct CB_RECALLANY4args {
>> + *		uint32_t	craa_objects_to_keep;
>> + *		bitmap4		craa_type_mask;
>> + *	};
>> + */
>> +static void
>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>> +{
>> +	__be32 *p;
>> +
>> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>> +	p =3D xdr_reserve_space(xdr, 4);
>> +	*p++ =3D xdr_zero;	/* craa_objects_to_keep */
>> +	p =3D xdr_reserve_space(xdr, 8);
>> +	*p++ =3D cpu_to_be32(1);
>> +	*p++ =3D cpu_to_be32(bmval);
>> +	hdr->nops++;
>> +}
>> +
>> +/*
>>  * CB_SEQUENCE4args
>>  *
>>  *	struct CB_SEQUENCE4args {
>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst =
*req, struct xdr_stream *xdr,
>> 	encode_cb_nops(&hdr);
>> }
>>=20
>> +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static void
>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>> +		struct xdr_stream *xdr, const void *data)
>> +{
>> +	const struct nfsd4_callback *cb =3D data;
>> +	struct nfs4_cb_compound_hdr hdr =3D {
>> +		.ident =3D cb->cb_clp->cl_cb_ident,
>> +		.minorversion =3D cb->cb_clp->cl_minorversion,
>> +	};
>> +
>> +	encode_cb_compound4args(xdr, &hdr);
>> +	encode_cb_sequence4args(xdr, cb, &hdr);
>> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>> +	encode_cb_nops(&hdr);
>> +}
>>=20
>> /*
>>  * NFSv4.0 and NFSv4.1 XDR decode functions
>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *=
rqstp,
>> 	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>> }
>>=20
>> +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static int
>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>> +				  struct xdr_stream *xdr,
>> +				  void *data)
>> +{
>> +	struct nfsd4_callback *cb =3D data;
>> +	struct nfs4_cb_compound_hdr hdr;
>> +	int status;
>> +
>> +	status =3D decode_cb_compound4res(xdr, &hdr);
>> +	if (unlikely(status))
>> +		return status;
>> +	status =3D decode_cb_sequence4res(xdr, cb);
>> +	if (unlikely(status || cb->cb_seq_status))
>> +		return status;
>> +	status =3D  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status)=
;
>> +	return status;
>> +}
>> +
>> #ifdef CONFIG_NFSD_PNFS
>> /*
>>  * CB_LAYOUTRECALL4args
>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[=
] =3D {
>> #endif
>> 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>> 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
>> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>> };
>>=20
>> static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 4e718500a00c..c60c937dece6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] =3D=
 {
>> 	[3] =3D {""},
>> };
>>=20
>> +static int
>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>> +			struct rpc_task *task)
>> +{
>> +	switch (task->tk_status) {
>> +	case -NFS4ERR_DELAY:
>> +		rpc_delay(task, 2 * HZ);
>> +		return 0;
>> +	default:
>> +		return 1;
>> +	}
>> +}
>> +
>> +static void
>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>> +{
>> +	cb->cb_clp->cl_recall_any_busy =3D false;
>> +	atomic_dec(&cb->cb_clp->cl_rpc_users);
>> +}
>=20
>=20
> This series probably ought to be one big patch. The problem is that
> you're adding a bunch of code to do CB_RECALL_ANY, but there is no way
> to call it without patch #2.

True enough, but there are other potential uses of CB_RECALL_ANY
(and I think Dai is about to add one or two to this series).

I haven't had a chance to look through these yet. I don't mind it
staying split for review, for now. When we get closer to merge,
we can consider squashing if there's still a problem.


> That makes it hard to judge whether there could be races and locking
> issues around the handling of cb_recall_any_busy, in particular. From
> patch #2, it looks like cb_recall_any_busy is protected by the
> nn->client_lock, but I don't think ->release is called with that held.

Then maybe the patches aren't split properly... if there are things
in the second patch that fix issues in the first, then those can be
moved as appropriate.

Adding the new XDR pieces in a separate patch makes sense to me, but
the other parts might be moved to 2/2, for instance.


> Also, cl_rpc_users is a refcount (though we don't necessarily free the
> object when it goes to zero). I think you need to call
> put_client_renew_locked here instead of just decrementing the counter.
>=20
>> +
>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
>> +	.done		=3D nfsd4_cb_recall_any_done,
>> +	.release	=3D nfsd4_cb_recall_any_release,
>> +};
>> +
>> static struct nfs4_client *create_client(struct xdr_netobj name,
>> 		struct svc_rqst *rqstp, nfs4_verifier *verf)
>> {
>> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct xd=
r_netobj name,
>> 		free_client(clp);
>> 		return NULL;
>> 	}
>> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>> 	return clp;
>> }
>>=20
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e2daef3cc003..49ca06169642 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>=20
>> 	unsigned int		cl_state;
>> 	atomic_t		cl_delegs_in_recall;
>> +
>> +	bool			cl_recall_any_busy;
>> +	uint32_t		cl_recall_any_bm;
>> +	struct nfsd4_callback	cl_recall_any;
>> };
>>=20
>> /* struct nfs4_client_reset
>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>> 	NFSPROC4_CLNT_CB_OFFLOAD,
>> 	NFSPROC4_CLNT_CB_SEQUENCE,
>> 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>> };
>>=20
>> +#define RCA4_TYPE_MASK_RDATA_DLG	0
>> +#define RCA4_TYPE_MASK_WDATA_DLG	1
>> +
>> /* Returns true iff a is later than b: */
>> static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_=
t *b)
>> {
>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>> index 547cf07cf4e0..0d39af1b00a0 100644
>> --- a/fs/nfsd/xdr4cb.h
>> +++ b/fs/nfsd/xdr4cb.h
>> @@ -48,3 +48,9 @@
>> #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>> 					cb_sequence_dec_sz +            \
>> 					op_dec_sz)
>> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
>> +					cb_sequence_enc_sz +            \
>> +					1 + 1 + 1)
>> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
>> +					cb_sequence_dec_sz +            \
>> +					op_dec_sz)
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



