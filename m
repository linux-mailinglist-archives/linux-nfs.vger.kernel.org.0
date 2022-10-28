Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24123611429
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ1OMO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJ1OMK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 10:12:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C591C7D45
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 07:12:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNnmx030166;
        Fri, 28 Oct 2022 14:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rGd3FJcChU+8FDOUdSDOpVjxx7EJqNGiEubUlVou1Uc=;
 b=yrtlG38pBbfMjm8cWmW6Z0PYVU/rQe6x3jDVQzv94u2gl/Y1QYLfsb4YJznZBWPKseqo
 1P7Sd7xAufyXExnsvMu61qS1DHsmRQF5Pn8EcuHL9r8FqmxjWZ9oSE3tUlOjDbaKqc3K
 Z85sRbnSaEKVDod6UEg+WXH9UAZ4kAyhBg8HgATct5cDJWjlEphm2u1TsKCoSD1vXEkg
 AGWs0LKiGVoDcjB3Z07dXzUG+uD91EuijGDzpUc/k/9y4ayPygRfpx+GFG0lzTIaUcQ9
 mYVj/TQo7qPLEeOlyQoJQO7Zgn43ChRdbnOGyqQA6S+IDnjH1+amQkj7AMuI5vN+0Bx+ Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv57sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:12:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SC0B12006597;
        Fri, 28 Oct 2022 14:12:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagj3han-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGdNuMDeOBTaMRKEdnuWv89RPi5NuJgu5S8ON+kVQdGP8BP4pqKPJbsiPMShdksahgD1kely7BGB1SqIKTECra2bVBPU7y17zYLGcnlD9WIIrHcs2CcTxHtva5/XoU29co5a8WJDKUoazHYIr02yde8ZT3muOvih6hOP8YbVrAB87mDXVknXkeD1tPJ8+lxMkBII7TmHKhhjwPNv+QtRn6GXBusj7UBSluhXn35Rhyd4/KM656kkueoQH5XDMzC+cnfV91OQ4RbSlwOOduIxvlMLldEv3/oHgj15Krz3fh3UTuzYHvrLmEEyl+M3BMx/10VDMeWUQeihTM1vx4YQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGd3FJcChU+8FDOUdSDOpVjxx7EJqNGiEubUlVou1Uc=;
 b=QGfES5QB2Z3DorG1TC8SwB88RVTPyB2kVPhkpRtgjikR+hwS3GIvO9z3r3P/F/FtyOjFt54TUPZy6C/DT7kESY49RifntvVGAaJS3c5VWJreffGCCYyaAEcqn1+dBh7ii9wzdGDAMXHJKVsy/IP5ZQcIXqkj29qAnc1z28fRkeRhHGasRRyOkrxwYOYvF/eQsaYeUrwa1GI/aPG7D1UpesgUNVMxtY5y7OoriJoDmKYsEIbEglaLPbccOySw4AB4YIqxCmnxYNHIN2Nd2ce2Eti01ky7PZHb02UKqWs6LeotU+gKoKf1Dtj/+mae9LG9e9UvMKiyfHfgl6ra3qwmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGd3FJcChU+8FDOUdSDOpVjxx7EJqNGiEubUlVou1Uc=;
 b=J105kgC4JAYaby2qztbewEsEXA3IEkWzjqMyM1b1muvzUtLZxL0zIIaES/2/Id5Dd2cXvc2P3vCPEe1AOJYIDBwGxv3Laz+s58Y/ulWgjaOTFQmt8UAlAvdJ3VAkYR+udOwBt1dM3dBe3to/+IX1lHFXjiTkxBvJVXz0UzBpARU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5242.namprd10.prod.outlook.com (2603:10b6:610:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 28 Oct
 2022 14:11:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 14:11:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Topic: [PATCH v3 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Index: AQHY6nNLIPitKTs0XEalLwD47leXtq4j2ZQA
Date:   Fri, 28 Oct 2022 14:11:59 +0000
Message-ID: <D080D405-5567-4581-A347-417E859A568D@oracle.com>
References: <1666923369-21235-1-git-send-email-dai.ngo@oracle.com>
 <1666923369-21235-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1666923369-21235-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5242:EE_
x-ms-office365-filtering-correlation-id: 5e738262-b8a9-48c9-7af4-08dab8ee60e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jM6rgB8sZNVmKAmXww9Ig09I7QUVsSeXwY9xYlTbxGTAQ0JRAFeqEEUoQVuNTOh7W6oTofES/iRdcZXEbVOzN1IgoryqOb826lYQgeevlEebetJI+85BrxNtHXB5LmlofDaaFEFCJTxTTeO1tttCK/PZuoLrYxeC1vFeY5GUMnznSgNWUPu1gJt1phBiewcYG+duMK3cnR/nvNI0+JB8BMsyc3ExdFh2eQUlOzxokLN+oQlaNGRIZZFKpuBR1hMt+cTLcjkvv2bpHrcr82W+S4qlPVzzLQmY3ir/NVGjO/7qfQdfOSC+Kwdm/s0yse0uN/eWCAKaDmUMFe1cyiRbWUv+UN2Z1+cGyLDgsNpa1Oi3p4L/zDEK5a0nZNVqDqTzTxw7qHUXyMJbQAjeOr7L5zrMItqMi5ZQiYJoSISx8bgQ1+oXCcDXvVDy+p9AvgQiVMqv4NTlwddVnOdq4qfXr0jvtpqv7T7TyC/bfonRyobg9gr7sV3Cav4anYaKXEplQ5bvaMpJXlvjmLEoCRgZKIXvB9v9oBEATb9k+ChVBKQJ9HuD3j7vZbGv1f/A1mCZFOs/VsNoTj18WWYIolD97mtTJLKuSl1ewT4MBmjvP1yrMBUZkpL2kjPiRnkoLyxJiL9j61KpgkBDlVV4a3tq3x9SSXzzSa87Amqhx7IS7ZX0mMWtGIHS2W8n42+IYeeN6esNmYx7iiB/W8VV9r0S5wnmtqjxzx2fUOBy0eFOC/i45fLSX2qU1FKZTis/4c6E+iicuPMkbvYqIAt2jGVhXnfZc3YMNdf9HlJrw1KZQLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(2906002)(86362001)(83380400001)(8936002)(6862004)(478600001)(71200400001)(6486002)(36756003)(5660300002)(41300700001)(33656002)(76116006)(66946007)(91956017)(38070700005)(4326008)(8676002)(66446008)(64756008)(66556008)(66476007)(37006003)(316002)(6636002)(54906003)(6512007)(26005)(53546011)(186003)(2616005)(122000001)(6506007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OcQ1h9Qa9cJ9exeHPgzJywV/j01d8ntpL15KgC/Aams2IqqIvf/3ldJNxaER?=
 =?us-ascii?Q?dbsWSWzMWyg8/G0nd3T0QUrL6Xxl0+tUG7R8QlCj3+NgVVIowExVQILFbNSr?=
 =?us-ascii?Q?jRuyfuIczZTXZ8GxZehjBbU++eXpv26zs9KpeEppyPEvdeUo8X/XQRAPWt2g?=
 =?us-ascii?Q?M2ZjncBJ1TjRa1oLprErI9L7eaOzCk11rMasozWXx66WWLSV/xhriaHuzYmv?=
 =?us-ascii?Q?gqa/HsluuuogC2AZp2SgR8i0NpoIW+7tCMl2TFof3NYWm7iKPRaKEzVEt9kn?=
 =?us-ascii?Q?5QKYak2I6pfHNG9hnFhUDAgf9CzrEl7mvugl0YU6CvXaTQ8Ic/8MciSu9XEw?=
 =?us-ascii?Q?qJ8JrLi2zlCH0O5vmM6WE5+frIVZvlwlx/YV10Ggxkwz8DPhOkAGQjNNuRJV?=
 =?us-ascii?Q?2durXcDwsF+hTxwcTDtFwsL0tFCtH9pcEC11+rnR9Zs8UCnsuu9fNoyR/5oO?=
 =?us-ascii?Q?/znKNV45x9p+xwz7lpY5159M4AhfFL3zy8Gmr5oFUscIJYNfeXwYZnQYKlMC?=
 =?us-ascii?Q?eXINmK00vu2ItasJ24ap8Fd5XY5zG0fmqKnDwBmhubCTmsFpn6AyMrDNgy+e?=
 =?us-ascii?Q?9cT2kV6eoDXIIE/gZT5baNHbUvTRtle8txog1oOJPxhUQfgsCZarPcgNDTi3?=
 =?us-ascii?Q?M4s/keNmXpPiwToP8PcfQ5HaDWmgYAM4/UBdo8Axsu5ooO2uPxniRpv7aDqX?=
 =?us-ascii?Q?2emFS9Z43ZH2n/g6OEXR9PdOrW9rpyvhkW6kMlt8TPDv57VmpRVH36bz17Rk?=
 =?us-ascii?Q?Kh7M8ilNFK1LF9F3K64jlCLc9DQVkyk1kBf0KVZXxNV2+Ensv805hYOsgaqW?=
 =?us-ascii?Q?p7x5HEtxdJ4v9DPv+T5HDbHAL60vzx6ieA2JffsHU4OY2oF6L0/gIxW1lJoM?=
 =?us-ascii?Q?Z2IdV2Kw+RaGckozI9Gq92on8E1SGtEI6Ty+irDf63FiVoDh3+d/BgWvaPfd?=
 =?us-ascii?Q?lqEz3Uox19l22X7DXdPXnTBhSYvctPhf8fIv0cj/oOyS5rrUp8h/e+N8gOtk?=
 =?us-ascii?Q?+3Z1OilolwMQxjIIjnIpa7NnEII6hP+skfPsNMVOm2TVnD8QCQPLjND17CNe?=
 =?us-ascii?Q?GG06C34Z1e6ywYBa+sAVjYufViEjiv0fdmmRrbvVU3CcL/I7DziECFdD7krI?=
 =?us-ascii?Q?14/oj7nnrbJijxXMlGKeXCnBgwXx3xtzkp8fJ7VtlkaOkHgXcZ8IF893OJxz?=
 =?us-ascii?Q?07UEQvGj7wn+ISa/CePmiAbJe6pc6j/C9usVac2iiNC0XiOLsHM4TnrMW+is?=
 =?us-ascii?Q?Q7ADdU9+7gZR59knmJYzamuL0R9zzUK9sG0sttCJ9nqK5lGboig0WkAq2Wrk?=
 =?us-ascii?Q?X9QVqns3r89W0BaHR10VvbAG0OgrpKvlFwHW3lEM6/vuVqXTXlI56lZCovnR?=
 =?us-ascii?Q?TEuQDT/1Gkym2StjngQ3mlfi4qiwvscUcC5+u6BntCaXhHL/VHz2En92FBUk?=
 =?us-ascii?Q?wDO6W3Sxe7xlV+pzd0jzfCTcy6KjADvQ+eoiEvj8+poG0NyZOSly8OL27Qk+?=
 =?us-ascii?Q?VMU9bjQpdCfHBZ0k5UI+b8gXTHO+bjrAQR+CmdvfLnVlqXvK3CR9P0xsgWwr?=
 =?us-ascii?Q?8jeHi7IcAkq7u/tTJGJRMqxgCHfpS4KcSrKN7Pd8VuOZVATovmEOgV6PfLmF?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46AC4576AB4A5244AE13F928D6BF9FAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e738262-b8a9-48c9-7af4-08dab8ee60e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 14:11:59.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+UtCrkVJE98RfWpNFWXHYgbCQED3ua4umZ/wdWIUxAvbA+RiVT8PzPt03r8NIai0qu6AqAUy+agtKYEPFUvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280088
X-Proofpoint-ORIG-GUID: DDGbeHwA_UoO2tlaVwq8NGlM9cshrJ1p
X-Proofpoint-GUID: DDGbeHwA_UoO2tlaVwq8NGlM9cshrJ1p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 27, 2022, at 10:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> There is only one nfsd4_callback, cl_recall_any, added for each
> nfs4_client.

Is only one needed at a time, or might NFSD need to send more
than one concurrently? So far it looks like the only reason to
limit it to one at a time is the way the cb_recall_any arguments
are passed to the XDR layer.


> Access to it must be serialized. For now it's done
> by the cl_recall_any_busy flag since it's used only by the
> delegation shrinker. If there is another consumer of CB_RECALL_ANY
> then a spinlock must be used.

The usual arrangement is to add the XDR infrastructure for a new
operation in one patch, and then add consumers in subsequent
patches. Can you move the hunks that change fs/nfsd/nfs4state.c
to 2/2 and update the above description accordingly?

In a separate patch you should add a trace_nfsd_cb_recall_any and
a trace_nfsd_cb_recall_any_done tracepoint. There are already nice
examples in fs/nfsd/trace.h for the other callback operations.


A little more below.


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4callback.c | 64 +++++++++++++++++++++++++++++++++++++++++++++=
+++++
> fs/nfsd/nfs4state.c    | 32 +++++++++++++++++++++++++
> fs/nfsd/state.h        |  8 +++++++
> fs/nfsd/xdr4cb.h       |  6 +++++
> 4 files changed, 110 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index f0e69edf5f0f..03587e1397f4 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream =
*xdr,
> }
>=20
> /*
> + * CB_RECALLANY4args
> + *
> + *	struct CB_RECALLANY4args {
> + *		uint32_t	craa_objects_to_keep;
> + *		bitmap4		craa_type_mask;
> + *	};
> + */
> +static void
> +encode_cb_recallany4args(struct xdr_stream *xdr,
> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
> +{
> +	__be32 *p;
> +
> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> +	p =3D xdr_reserve_space(xdr, 4);
> +	*p++ =3D xdr_zero;	/* craa_objects_to_keep */

Let's use xdr_stream_encode_u32() here. Would it be reasonable
for the upper layer to provide this value, or will NFSD always
want it to be zero?


> +	p =3D xdr_reserve_space(xdr, 8);

Let's use xdr_stream_encode_uint32_array() here. encode_cb_recallany4args's
caller should pass a u32 * and a length, not just a simple u32.


> +	*p++ =3D cpu_to_be32(1);
> +	*p++ =3D cpu_to_be32(bmval);
> +	hdr->nops++;
> +}
> +
> +/*
>  * CB_SEQUENCE4args
>  *
>  *	struct CB_SEQUENCE4args {
> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *=
req, struct xdr_stream *xdr,
> 	encode_cb_nops(&hdr);
> }
>=20
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static void
> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
> +		struct xdr_stream *xdr, const void *data)
> +{
> +	const struct nfsd4_callback *cb =3D data;
> +	struct nfs4_cb_compound_hdr hdr =3D {
> +		.ident =3D cb->cb_clp->cl_cb_ident,
> +		.minorversion =3D cb->cb_clp->cl_minorversion,
> +	};
> +
> +	encode_cb_compound4args(xdr, &hdr);
> +	encode_cb_sequence4args(xdr, cb, &hdr);
> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
> +	encode_cb_nops(&hdr);
> +}
>=20
> /*
>  * NFSv4.0 and NFSv4.1 XDR decode functions
> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *r=
qstp,
> 	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
> }
>=20
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static int
> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
> +				  struct xdr_stream *xdr,
> +				  void *data)
> +{
> +	struct nfsd4_callback *cb =3D data;
> +	struct nfs4_cb_compound_hdr hdr;
> +	int status;
> +
> +	status =3D decode_cb_compound4res(xdr, &hdr);
> +	if (unlikely(status))
> +		return status;
> +	status =3D decode_cb_sequence4res(xdr, cb);
> +	if (unlikely(status || cb->cb_seq_status))
> +		return status;
> +	status =3D  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
> +	return status;
> +}
> +
> #ifdef CONFIG_NFSD_PNFS
> /*
>  * CB_LAYOUTRECALL4args
> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[]=
 =3D {
> #endif
> 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
> 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
> };
>=20
> static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4e718500a00c..68d049973ce3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2854,6 +2854,36 @@ static const struct tree_descr client_files[] =3D =
{
> 	[3] =3D {""},
> };
>=20
> +static int
> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> +			struct rpc_task *task)
> +{
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> +{
> +	struct nfs4_client *clp =3D cb->cb_clp;
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	clp->cl_recall_any_busy =3D false;
> +	put_client_renew_locked(clp);
> +	spin_unlock(&nn->client_lock);
> +}
> +
> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
> +	.done		=3D nfsd4_cb_recall_any_done,
> +	.release	=3D nfsd4_cb_recall_any_release,
> +};
> +
> static struct nfs4_client *create_client(struct xdr_netobj name,
> 		struct svc_rqst *rqstp, nfs4_verifier *verf)
> {
> @@ -2891,6 +2921,8 @@ static struct nfs4_client *create_client(struct xdr=
_netobj name,
> 		free_client(clp);
> 		return NULL;
> 	}
> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
> +			NFSPROC4_CLNT_CB_RECALL_ANY);
> 	return clp;
> }
>=20
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e2daef3cc003..49ca06169642 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -411,6 +411,10 @@ struct nfs4_client {
>=20
> 	unsigned int		cl_state;
> 	atomic_t		cl_delegs_in_recall;
> +
> +	bool			cl_recall_any_busy;

Rather than adding a boolean field, you could add a bit to
cl_flags.

I'm not convinced you need to add the argument fields here...
I think kmalloc'ing the arguments and then freeing them in
nfsd4_cb_recall_any_release() would be sufficient.


> +	uint32_t		cl_recall_any_bm;
> +	struct nfsd4_callback	cl_recall_any;
> };
>=20
> /* struct nfs4_client_reset
> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
> 	NFSPROC4_CLNT_CB_OFFLOAD,
> 	NFSPROC4_CLNT_CB_SEQUENCE,
> 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
> +	NFSPROC4_CLNT_CB_RECALL_ANY,
> };
>=20
> +#define RCA4_TYPE_MASK_RDATA_DLG	0
> +#define RCA4_TYPE_MASK_WDATA_DLG	1
> +
> /* Returns true iff a is later than b: */
> static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t=
 *b)
> {
> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> index 547cf07cf4e0..0d39af1b00a0 100644
> --- a/fs/nfsd/xdr4cb.h
> +++ b/fs/nfsd/xdr4cb.h
> @@ -48,3 +48,9 @@
> #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
> 					cb_sequence_dec_sz +            \
> 					op_dec_sz)
> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
> +					cb_sequence_enc_sz +            \
> +					1 + 1 + 1)
> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
> +					cb_sequence_dec_sz +            \
> +					op_dec_sz)
> --=20
> 2.9.5
>=20

--
Chuck Lever



