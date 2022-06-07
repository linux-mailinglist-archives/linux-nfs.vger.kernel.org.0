Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31FD53F3E2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 04:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiFGCVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 22:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiFGCVX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 22:21:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B358B11A0D
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 19:21:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256NdFO2003622;
        Tue, 7 Jun 2022 02:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wk80wc6dxBnSQmeMl4+r1t/erF2mHhZgjCD7Qttly64=;
 b=0XTrpcKw3OMx0bfrFcp4E4OwbarC2YySClxZzShkM4LdJ+SKiCMF7sPL6jRxxfDsN+Vm
 rzWofCWdsoX5ILNSaB0MDE2B27u7y5LfmOEnmy4DuK2ZqtYS7kvLFNkVxTmjfYKBzPZD
 NkA2gk+NStoNudszZI2u614E4Vwde3Iu45weByQFeNOLUlJf4XkcAqrCYUOj41tJclio
 gws9Ggf5FLa4K5OnB4FiJ7afVesogVViR1z09fu/VLDRS1/HvCTkA8/YDzqDe/YFwEQK
 5no2MbNTsRaFv+imQZT2OhgdcTa9C0qGiQtwDyvuGo9Yp8pj7pzCZ7VK57bA9uifH+0o Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekcfd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 02:21:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2572GU2C017557;
        Tue, 7 Jun 2022 02:21:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu237mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 02:21:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzNlXq4h2twfmT8mYRIfdcWQJfiPywRLZmSzJ+Roq4Hv6eWUux65ByO4g33EQifFbE2LQKePzKss4fBjSSdAV+D//IfPaK5x0JlXQbnE+qPydmZR2eG4nI2wJregSiuQ1EBswS/FycR3MOAU/K5jleKgs45/sWRMheGPgQmFhJFPYHWtRZ47K/gnLfZzs80Fn7mj+3mmKxjJV5si1RhqBGU8qBCOjWcCbbAj4jAy8GPgK9N+wg42xU41BxygAnlsCf5nonQ9HGAugT/3VWF0c/Tn5xRStlQlDAfM48W4SdoBBRUAgQ0EKOCCq2/G/j1//hjGdhfxTqsAildtNurmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk80wc6dxBnSQmeMl4+r1t/erF2mHhZgjCD7Qttly64=;
 b=kGmraHRZRWM+3spL7jB4Szkt+v3rWV1Ie8BnCIusnOMifxxOwZ5hiLIjMTzmM47nzMmtbTIfDmk6SWjUjnGp3p+KcST9Xc/SgK3L9+hGMicBkd3zBaOKPIP0HuXM7cLRAZJQ8k4vj1BmMAPEPvXP+aLM+KCbkpT+8AJOlj1BtHMsNAoFW+47n1P2dnUoR1w8B1rYEpxvhmPHoCelSZrUZ1z/fv88qszroqMwrBnhZ2F25stE34T3Q3ey0wSm2GFZd82XIioGFG3vUXLDa+rM7XWsp+qzmhnCB560k7bXNwEnrD8Dykk61QZ8FjP4U2kwNMZJe2e1oXrd4KDrQx76UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk80wc6dxBnSQmeMl4+r1t/erF2mHhZgjCD7Qttly64=;
 b=dxwoJlbGQA1sntcUNyKz3wLdKdI5SGOY6L4J/Ael+jvPArF7vtY9JAmZ0VRAUz+f5rxHIERsocZrXk9gjcT/khif0GsFSrII9FQqvDl+uWr3u5dDHZhCNL9wM+tbPAcegHNijBV6ILP9c34ZfTv9n457jZ3pBltbw6VafHzDUV8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3310.namprd10.prod.outlook.com (2603:10b6:208:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 02:21:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 02:21:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] SUNRPC: Clean up xdr_commit_encode()
Thread-Topic: [PATCH v1 3/5] SUNRPC: Clean up xdr_commit_encode()
Thread-Index: AQHYeRas7D6Xx6toDUKPtABcCLLMta1DI0QAgAAVEQA=
Date:   Tue, 7 Jun 2022 02:21:13 +0000
Message-ID: <BCB98EE4-9824-4147-8D21-47110914D51F@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
 <165445911819.1664.8436212544546306528.stgit@bazille.1015granger.net>
 <165456394819.22243.15333379326870400835@noble.neil.brown.name>
In-Reply-To: <165456394819.22243.15333379326870400835@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9620d4bb-651f-403f-df91-08da482c64b1
x-ms-traffictypediagnostic: MN2PR10MB3310:EE_
x-microsoft-antispam-prvs: <MN2PR10MB33100F7FC62417B711CCA3A593A59@MN2PR10MB3310.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcoP/6Kix/Tx0P7KCA2FdN6z2w+InOXjnO8CnafTYFmqCMPFDhww0ag8YDyICYkUlLMslAySzgkQvoJJmDX3EEueD8BgsMIxrlUCgK145Odx5S9eSNxYTfM/TnKOK9SIqpYejHwFClv01ofMcYdI9fmrF5fKPPzqhlQnCNCQ2cV61WWKoJnhU4b62qzdS9L0/MLG5Kzk+kbF38+PH9bi/uzFh8pvEvLvEEcUOs+qP8w8CWeDQMfODK0++EflHNz6ZEXx67yxpm3etwDf3K1Vj/YhHmefZ8LFb4cBrbxNXPgGFvG1qyuWedKDkbjti4knW273cWJviY3Vrt/OaHvnuZjKqdTvyoOC9ZD+LejsbaYJtUqOnBOvlx0Nh6h3ppjiu8w9oxpaBBr96Unlgj95xEiuzC19Fwiu0eAGDPWRGhGT9bXwD/M1n2QUTA2Etea9JTU2mGlDMZiPixXvB83O8a5LPmw5oBBngwf3FBMLScQpcFKMx+JczrrEQWxSaZYh0pRI0a2mel7GM5woYAhHyccjBdDD7BONyWiDUtwhhrz9eLSZDzn6CTngCxsvq3LLvSGp7sM5q+kHHALAq75pwhIjHzKwdDiRAEPiTHQ0z1ePosHv6M4AT9PavCXWGIt4ZRwDWNf5T+SCwlTS0dgHqRJkKF8xM1ad3CPHrqjgpl0OZWToBGmxhSY8JzP3/VhYuusqYt7SCG6S6TTi/cR3hU7f6/wPqLgx//efyiNN7lz7MOr1wZEQhqaCQA61nQjL1Is6FL6X2fNeWvS/Smuj+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(36756003)(66446008)(38070700005)(64756008)(6486002)(76116006)(2906002)(2616005)(6512007)(6506007)(91956017)(26005)(122000001)(53546011)(66476007)(4326008)(66556008)(6916009)(8676002)(38100700002)(83380400001)(316002)(186003)(66946007)(86362001)(8936002)(508600001)(33656002)(71200400001)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ffMjH9e35zRiZFzHYG/1xUsEj2jGVpgTWFlWPyyTo0XFd94m9RMQPRn6BeTb?=
 =?us-ascii?Q?kXTTgm70QDcrDvAqYobXIXFTpdG1e+ZMotz3of+6sH5mxyb//9pDaBiADmAP?=
 =?us-ascii?Q?1RL2p0sIbQVyuWRHt6ZCrOAtfBxp3GyYDpdMnIwpfkCwPD5szm6HEYEhrWXK?=
 =?us-ascii?Q?zDYoq6zGCjUHV/Xph+jM0N/kVXCI0Zn7hpa+erYoU6v2E4LxdBsmEGV0Lc9R?=
 =?us-ascii?Q?E6KUGw2IwRGD3Bzq1Qybbtx5Jy7vosdD4B5JDn+uFOKnzA5O/XFTlTUBv4LW?=
 =?us-ascii?Q?1pj8V0C4Hg6g9Rag32c7vMEk+BBNxvKN0TN69atFkY8EnzAsOEtZsDIxme04?=
 =?us-ascii?Q?uGf8LI9pEcCDfrrCg2PEBv28QWUrDig/+f1/t/eeNGm7O42sprCx5X5R9tKt?=
 =?us-ascii?Q?R31dygX3Wn/Fdh4BOsQC2tkgE5Oi0BaRIfxckrZplZty99u2b+vt1E9tk3Go?=
 =?us-ascii?Q?10KsbtKwkOpuAWFJwztSdd8Y7y/ZNaQSsGxDhkoaQuYAwpnP+5xYnDBV9OSy?=
 =?us-ascii?Q?5Nl2a0s3Vg35sQoPJxQqRTt4NMrCsU9B/M3QmXu+dXlucLjZ3omU+dpfzwro?=
 =?us-ascii?Q?TVq78w+F0Yc1hj4Mfc5G8cEqwyPfs5fMKWkfxvIv7O8eDaF22Yak3PDhQmkv?=
 =?us-ascii?Q?w4o+UI4hA8WgEiYR7yWa6ajVpJpQxNVs52gO+AP3E+nvdrq90cx0MQRXRT6h?=
 =?us-ascii?Q?9RrwFepmjyedUP6/JB64QvQIlAehWNTIe2JlsMURAZ3YkwpcBRIskCTgxq/t?=
 =?us-ascii?Q?NbTvoqQTrWhqGafsR+O64WtMTsTGgffhltuTsriZJtiMG4zYa+zch6/XnayR?=
 =?us-ascii?Q?Wp5ph8WMAhWTk5emGIXpKmRTY8LZfedT4hTda4RbcDi1yCuTfV0H+gu0BHoK?=
 =?us-ascii?Q?tQijfH1tr+hT7UGHrqB7/aNu/u+lguICSFbZ8yTeRFn6M76QNvgy1dBpLdsm?=
 =?us-ascii?Q?K87n3geCpB+4NfFGlTyHUvRad9YEvsP76TvVJWbGglGJIAu1/uJxF7CbNTlH?=
 =?us-ascii?Q?5CptPCc2/B/eYCHdyHQf5ik23dkDnl4O7yZk/OlF1APlk/I9Idn3Akx1vuSa?=
 =?us-ascii?Q?oOWyAjIWkDT3iR/HewNBEZpvnOB3rbE4kI+Fn5lDwgDVxXi5bjmwhdHMAUim?=
 =?us-ascii?Q?CVRXntykd9CDZHo61Vbubv5FYLk7wpbWVuyF6SB6Wq2N/5+ctf1Ifo6AbiFo?=
 =?us-ascii?Q?qKBQusXVTJAz8tE3fhW5hZoeWnAXI+dzSdgRKxeN/TnowaMGYLr9nd3EqLAw?=
 =?us-ascii?Q?OVvZ1T3qdG1rRBdVZkZWbR0gWimvePwXObejZ27E4J65eQOyYIpYRNLebEPB?=
 =?us-ascii?Q?LmIrMZXLzkYuXxBjQC3CwH7Chn05GujtQfF/zLrYFE9giFHJeOI5BbNg+kzY?=
 =?us-ascii?Q?cNhNplYU69aP8BFfgutTLlma+5K1qB9PUIAOKDliO/K42+AhRHfnIN//VXB5?=
 =?us-ascii?Q?dTbunOlt1PbRDUeWZDjHt4YxWq6IvuYvSYW0ZddpErb76dROxGd79IFmY8W9?=
 =?us-ascii?Q?doQ6kI7c6Am8rd59dOuMSS966RufaAmG1dvS1lRoDYUlL4oUmnvwCgoqAFf8?=
 =?us-ascii?Q?C+aue50aew7F7tMpAlc4PeuDFG9s56XPuuN0L33v74us0Hz0LAiCdzk1YLuH?=
 =?us-ascii?Q?Lf6stNnRgG5CoOfT2yVjCYhQMfhlPnzc5S5+v7qVO1f+3Fer83HP91lqQqtB?=
 =?us-ascii?Q?ky8sixX/jSqIoU0xqbuI6px1fLtZCNRv3fhQEZoiDFJWizTmVlXAQYwoz5dO?=
 =?us-ascii?Q?+MA95I2Jd9sgWcOgB/74Xs13NpHwm+U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E46D9409563E9943A744F8CAF278F120@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9620d4bb-651f-403f-df91-08da482c64b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 02:21:13.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwfacfXTuxh9aKK+H76EzUsESoc/JfaS2337BjulbYjaE8BECfNXmFoxh3TtbVrxfsBAq4/o5IlG45LmBGORAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3310
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_07:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206070009
X-Proofpoint-GUID: 7GNfy4VkT2rBAuhF33m4h0uLpTsMqi4c
X-Proofpoint-ORIG-GUID: 7GNfy4VkT2rBAuhF33m4h0uLpTsMqi4c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 6, 2022, at 9:05 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, 06 Jun 2022, Chuck Lever wrote:
>> Both the ::iov_len field and the third parameter of memcpy() and
>> memmove() are size_t. There's no reason for the implicit conversion
>> from size_t to int and back. Change the type of @shift to make the
>> code easier to read and understand.
>=20
> I wouldn't object to "shift" being renamed "frag1bytes" to make the
> connection with xdr_get_next_encode_buffer() more blatant..

I thought of that. Readers would wonder why frag1bytes in
xdr_commit_encode() was a size_t, but in xdr_get_next_encode_buffer()
it's a signed int. It started to become a longer string to pull.
Maybe it's worth it?


> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown
>=20
>=20
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/xdr.c |    4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 08a85375b311..de8f71468637 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -933,14 +933,16 @@ EXPORT_SYMBOL_GPL(xdr_init_encode);
>>  */
>> inline void xdr_commit_encode(struct xdr_stream *xdr)
>> {
>> -	int shift =3D xdr->scratch.iov_len;
>> +	size_t shift =3D xdr->scratch.iov_len;
>> 	void *page;
>>=20
>> 	if (shift =3D=3D 0)
>> 		return;
>> +
>> 	page =3D page_address(*xdr->page_ptr);
>> 	memcpy(xdr->scratch.iov_base, page, shift);
>> 	memmove(page, page + shift, (void *)xdr->p - page);
>> +
>> 	xdr_reset_scratch_buffer(xdr);
>> }
>> EXPORT_SYMBOL_GPL(xdr_commit_encode);
>>=20
>>=20
>>=20

--
Chuck Lever



