Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADCC4B54C5
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 16:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbiBNP3E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 10:29:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345116AbiBNP3D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 10:29:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC9C65
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 07:28:55 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EEkAFs031171;
        Mon, 14 Feb 2022 15:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qUW0pwidy4kMhoYe7E+zkFn0OlW/M8CJ9KJO9FlvStI=;
 b=Jl+zMvuHie6KcbGKgB+35XZ52mQZ7mfelZvhDE7umBCk9ujUekGFK+kyWcy9JVbkYeBh
 nHHKkWFo/Gsf3yuMdbt2e3JkuywT2sDXrqNZ45F7jhdHzUPRbwkpo/4YTKLjKfOtKcND
 ERVOzPYZUmd35OHn2Vj6HmAeI5szWzF8UbrmSorEziI+mhSW20dTpLjmxKlZnmjWWzzm
 BEMJSEYyG3UQoXy134V0Sy2Xpyk92MhIyGGhJHK1uQqd541HKO/BEPIF2qhpjvsaMzGR
 g0t53+mKdyHUoAkSho9IKQDIhOuem2xeWqNYfF8p8KFO/k64e5XrnTFW+mgjaxDxbyUP bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbvm0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 15:27:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EFG2k0045243;
        Mon, 14 Feb 2022 15:26:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3e6qkwunbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 15:26:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpX3MdzYnB/esA+Xz8FLTZePXYP+2llM5WiSyV4XJo6vgvTseTPoJiaqKGiSTEeh0d2+/934y1R5T7aaJewi7GuYg/P8m6C5UiPww/B/h9t94J1m/QlG6YaLVuhVWKKt7VRdgN4XvpEKGK4jRE23vLxDqTyGeBwsKs1XywEB0ngenV9+EHmJ8Rq1D5EY7Wj2nTvSqqmq5ZN1zYjdWaeEmTPlRAJQvXSFFPsFaveR+G1p8g/EGFE4FxNFfUJVWpfcegx6sZ7Z4u9/L+2NzOJph0xp9RivnqyVT0MjQKfwvusZvvVewNDOsBXrqqDIyBsUFtr3SR9ehZc/O3HYx3V+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUW0pwidy4kMhoYe7E+zkFn0OlW/M8CJ9KJO9FlvStI=;
 b=adLkY6o8ZUAriYnFB+TIJqaouIwvMIPLCxSeBSMH+Bo0+XUL1BRHS4GnBa9eOX7jWlsBLz8I9gtpSDTePY1XVga1aoNOY+NQfzCxrwz44bijfQr+giezQQ3GZlfI0aXaq035Z6JoIJ2yJbmIV3RQn5j/RFxG/nTbjvC6HuehLWSqwRHIMtAxGssLZxK3v42N9bV3+9vi3dOxVViU/2W0Q/FgiwwdWp2vsvnMHEAaTBpaix9r5zGEJ5wxpSbO4hwafoxcqH6bFkq8CSG8DjRNm+sdA/MfTw2qtCcUCuib3iyeS5mzOOaxlLbG0vFRVzHlxZk04k9hfcxCh5Vrp6doqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUW0pwidy4kMhoYe7E+zkFn0OlW/M8CJ9KJO9FlvStI=;
 b=WhRqQHcPJfF4k0udLC8MrQEwql1ktRutGRUN6VmKJ0wxXRx3YJ0OVwwV4x9V5jKRX1TbHAEe4Kmz675B1KlmimasliEd5VHHIccEzjO8gSczjv0x9zrUZ/4soHzFIAIwoq6EVrQfTdzBN5YwYzLJal7eLLZ07fdkViJvO5Pd+5w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5365.namprd10.prod.outlook.com (2603:10b6:408:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 15:26:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 15:26:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thomas Blume <Thomas.Blume@suse.com>
CC:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Topic: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Index: AQHYIYhKDk3jkCVie0yBKH6y3YG1OqyTK2AA
Date:   Mon, 14 Feb 2022 15:26:23 +0000
Message-ID: <F1A91E0B-4544-4739-ADAD-CF9FCC9E8F66@oracle.com>
References: <20220214092607.24387-1-Thomas.Blume@suse.com>
In-Reply-To: <20220214092607.24387-1-Thomas.Blume@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b65155fd-ba40-493b-b4de-08d9efce5bcb
x-ms-traffictypediagnostic: BN0PR10MB5365:EE_
x-microsoft-antispam-prvs: <BN0PR10MB536528A5E5222DC71F155E2B93339@BN0PR10MB5365.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QnBDE2+A2bPTdl7tx1x7embjtsOzPueb70mRgnI1t5M4Spy0uU5mgpyqnzfFnVPo5szc6I25FYEsmL3HW5ZR4WLd9q+5ANVh3Jy8K48JG7eUqQzQ7WU2OhzOQ1c8B2yTeBTOb7lAMzcDPy0FE17cEY9qXIz1BjzYMlmeXEWyhDRWbSsKFpOch6Ulz06ITLVCEKmbXpa5+BM2fpG4UklcPV77ESOo/QWDHgVzU6DSum3FsyBYkEOFqMXhQDZb9+vBjCjoTPGfbv1C/8LGeRbxzK+6JFNBW43AXvMxoJicameDUiGV1HNC90q9yn4WgCrW05LhzbfybtB6Et8SrRwZj+p6wTQPvE+0aWzMbgkl3K4ipzkjri+u200gbNQOPHcsLPjZ0Re+AqeMtviCQkspC58Sgui+NmkvXoddnmw8CNkjspii5wnPVn6W+KtP/dqR5qK+0oRXL5c6Ye3ZTx1WUDelEYuVqcMxCRCEZ4BZDkB4b+5o+TCajwKrh6k7WA1NMHCgbrRRY+3u6Oc+s/Qqkp59mgH31j6UEGirHn4YyT5/IC+ho9k9J330S/783+P4qsXbukvnJvHhawuZP/MJ0QRN8AKtuq8hrqZ5U8j2MK/x72DdswTt0fHDyh2MVg+i3nbHH+75I78O/UVjX3P5m/x5rQIQOhbOL69NbpDaRGKRiTmyFVnhv4nvdYedW1sTDSqm6mxDxTqphl3iDaRpkRBZ+0PuIiJCK/BVf2nri/f4G2xbfo761mLJusAXf0UyAb74ZpcJIE0is28EDUA/MH4TJz45Ky3zvpkc1aYk8DoYRYbrnDYn6qKIG5FUk5D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(5660300002)(26005)(186003)(2616005)(122000001)(36756003)(2906002)(53546011)(71200400001)(4326008)(6916009)(76116006)(6486002)(508600001)(66556008)(66476007)(66446008)(64756008)(66946007)(86362001)(966005)(91956017)(54906003)(38070700005)(8676002)(33656002)(8936002)(83380400001)(316002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hzkRpH6rmCDyQEbMczDfJIC3GU9np8adiNzvQFAOdnSsoiwCagqPeVzQY7v2?=
 =?us-ascii?Q?mm+TA6xbCnQ4mPDRDngVoG4FV4CJsDPbUZfrbH29786vddlFDPTYLgdO2cCo?=
 =?us-ascii?Q?dbI1awOMJiKg/zfl5c3Gmc86lKLR9Q+SR1skwkd86X47o97buEguq7N35+xh?=
 =?us-ascii?Q?hAKLWOz561VAZm2MZlpg8kuM9WbqXKhH6waztpRes/wECZUsO7xc+M3V5S5j?=
 =?us-ascii?Q?f6gmOWTp+RIILLkSZAZHCroWygcD+UnAli9QWVgidi6pvsKllXCr+KFagii3?=
 =?us-ascii?Q?1coOfOOvQHSx7ttwdINN21M4G75eLJbYLWx1HTBbkVh0opQlUZ6VLT0Wfy4r?=
 =?us-ascii?Q?eCzVJROpkZOMC7p3cbv6f8x9HRXIi+qAfAnySuCZPHrONhLBHDDJdUd5G+ju?=
 =?us-ascii?Q?vUxQiTXbpcdLgs63OqbMKLDCnCKq0Z7P2p0a5vOa5+SFNv687ZFv5Tn5U6/8?=
 =?us-ascii?Q?IOYWGQTTnbAlDAtb6qw/CThSn4cFkuJh+t62ejdrFG1QelFD22nq5tG0lv0l?=
 =?us-ascii?Q?iO0605XRH2z5T0vAInkMrdraY80rxyyGmuTbK4GRLXilepXG+W99VuNRhtKT?=
 =?us-ascii?Q?pOD1fQ52ZapQoStY6FcrVGT6/TYHZl3g4kCYP6+IUrorgit0x0OM+Idr5DuI?=
 =?us-ascii?Q?HDiA2ZODJSrhyzrkQ7f6CL6ZoWh0kwMt5QwQ00oFC24uQraUjY7qZazFNFg0?=
 =?us-ascii?Q?352P4d0fmrcPDPuWIWu+W5zp8yegliqhKrJ+JL2GMDtIaiV4ZiAI1LwcgRw8?=
 =?us-ascii?Q?8HJFMKyet1ykVypyvrSu/yF3SzI8qnd0pnXGBJH4a3oXxnhIWzuIwVTRwDuw?=
 =?us-ascii?Q?AlOjuegVexQq8TCrV5lKlo2ADhgX910s90Ctydp4PqYHnPiTsbBMnO2ZJ9Bu?=
 =?us-ascii?Q?F4BaobrOQRew9sst+7v5lo8rBh30G+eq0pOQ5rnJaluoIGEkWPTUoSqMzoow?=
 =?us-ascii?Q?nNuPAlPYxhKkWLjsjwMoKYYEUfZ8Qr/ZQIzZJsCY3N1fSTOwH/fuEOZiDtcq?=
 =?us-ascii?Q?nGqSPRhrXwAGquV8wksvHOZ4MYHXCB91i6RzTFMDIeIiTxgDvEW2oeLMFIHe?=
 =?us-ascii?Q?ECkPvZ/Ede8B7sUEMWI/a3r3G46fiVDK6asi65s5+Ngh/ozsPqi4Xj/qToA1?=
 =?us-ascii?Q?o3S6RYyqBS/2Lv5Ma7dbv3KC6njk/gMVtFa84yKsytp2DInfgJFcIRRd+1UR?=
 =?us-ascii?Q?lv+ZssjpNuT5WmL7exGZ4TpBAAWloCUR//kn7dAAa/TqGr/EDqe5z9moLybF?=
 =?us-ascii?Q?0jFrv/yDMBZoAsoz3bh2dkLamoKVBxr7hKz7lQLpfZIe7UTrRNY8hWjJ5kug?=
 =?us-ascii?Q?rVVd3dJNKyZSopFuzRzZIwBVwiguCQL2msr5hU/+eS1Qc16rv+8sM/YVIRrf?=
 =?us-ascii?Q?HIBHzilfU6koNS0F464cB7mAaWXa0kmtWM790+cwqr0c+mr4dKR0/pnTS/tw?=
 =?us-ascii?Q?Fw8UNmJjRqcZGIzq5URnAoMHCiMdX2NStVpYaQ90VaiypP/xV+u9P/rIG4ia?=
 =?us-ascii?Q?s2BWr0hIL3grvlJshY4n+mBZOzzQdGop1d6lT41HIPj+nI2175GCYEmVHSGr?=
 =?us-ascii?Q?W2vg4bIdqMH4SVNz/v7djKCm1vn8FHwYZ1EnT9SlepaMKr1rVHU5kOcWxg6G?=
 =?us-ascii?Q?Deeqn+cyuO/4sKN9qp4Dt6g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90C88A150DFADC4C9591F2F3C033CE4D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65155fd-ba40-493b-b4de-08d9efce5bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 15:26:23.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zT4aJgG+Hb1JrijvEpgORzsHnFtiAIg+fesN5c5LeHZ+RExRfE4wS19bTTO7Dim3qDDTvv+93lvpeCA6pwbfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5365
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140094
X-Proofpoint-GUID: V1daFmlQIEUhHokcr7_wvfyZVJi0-af0
X-Proofpoint-ORIG-GUID: V1daFmlQIEUhHokcr7_wvfyZVJi0-af0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Thomas -

> On Feb 14, 2022, at 4:26 AM, Thomas Blume via Libtirpc-devel <libtirpc-de=
vel@lists.sourceforge.net> wrote:
>=20
> In some setups, it is necessary to try rpc protocol version 2 first.

Before applying this, I hope we can review previous discussions of
this issue. I've forgotten the reason some users prefer it, or
maybe I'm just imagining we've discussed it before :-)

The patch description, at the very least, has to have a lot more
detail about why this change is needed. Can it provide a URL to
threads in an email archive, for example?


> Creating the file  /etc/netconfig-try-2-first will enforce this.

A nicer administrative API would enable you to update the whole
rpcbind version order, but that might be more work than you want
to pursue.

It would be a nicer if, instead of a separate file, a line is
added to /etc/netconfig to toggle this behavior, or provide the
whole version order. E.g.

# rpcbind 4 3 2

# rpcbind 2 4

Really, though, this isn't related to the transport definitions
in /etc/netconfig, so a separate configuration file might be
more appropriate.


> Signed-off-by: Thomas Blume <Thomas.Blume@suse.com>
> ---
> man/Makefile.am             |  1 +
> man/netconfig-try-2-first.7 | 18 ++++++++++++++++++
> man/netconfig.5             |  1 +
> src/rpcb_clnt.c             | 29 ++++++++++++++++++++++++++---
> 4 files changed, 46 insertions(+), 3 deletions(-)
> create mode 100644 man/netconfig-try-2-first.7
>=20
> diff --git a/man/Makefile.am b/man/Makefile.am
> index fa43bb4..38907d4 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -16,6 +16,7 @@ RPCSEC_MANS		=3D rpcsec_gss.3t rpc_gss_get_error.3t \
> 			  rpc_gss_get_principal_name.3t rpc_gss_set_callback.3t \
> 			  rpc_gss_set_svc_name.3t rpc_gss_svc_max_data_length.3t
>=20
> +dist_man7_MANS		=3D netconfig-try-2-first.7
> dist_man5_MANS		=3D netconfig.5
> dist_man3_MANS		=3D $(LOOKUP_MANS) $(NETCONFIG_MANS) \
> 			  $(BIND_MANS) $(GENERIC_MANS) $(COMPAT_MANS) \
> diff --git a/man/netconfig-try-2-first.7 b/man/netconfig-try-2-first.7
> new file mode 100644
> index 0000000..475c483
> --- /dev/null
> +++ b/man/netconfig-try-2-first.7
> @@ -0,0 +1,18 @@
> +.Dd January 16, 2019
> +.Dt NETCONFIG-TRY-2-FIRST 7
> +.Os
> +.Sh NAME
> +.Nm netconfig-try-2-first
> +.Nd indicator to enfore tcp protocol version 2
> +.Sh SYNOPSIS
> +.Pa /etc/netconfig-try-2-first
> +.Sh DESCRIPTION
> +libtirpc tries per default for transport UDP and TCP the rpc protocol ve=
rsions
> +in the sequence 4, 3, 2.

There is good reason for this behavior. The man page needs to
explain the risks of changing it.

Does this break behavior on IPv6-only setups? Is there an added
security risk?


> +In some setups, it is necessary to try rpc protocol version 2 first.
> +Creating the file
> +.Nm
> +will enforce this.
> +.Ed
> +.Sh FILES
> +/etc/netconfig-try-2-first
> diff --git a/man/netconfig.5 b/man/netconfig.5
> index e8dcbb2..beaf27a 100644
> --- a/man/netconfig.5
> +++ b/man/netconfig.5
> @@ -119,5 +119,6 @@ struct netconfig {
> .It Pa /etc/netconfig
> .El
> .Sh SEE ALSO
> +.Xr netconfig-try-2-first 7 ,
> .Xr getnetconfig 3 ,
> .Xr getnetpath 3
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index 0c34cb7..d0336b9 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -32,6 +32,7 @@
>  */
> #include <pthread.h>
> #include <reentrant.h>
> +#include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <sys/un.h>
> @@ -838,6 +839,9 @@ __rpcb_findaddr_timed(program, version, nconf, host, =
clpp, tp)
> {
> #ifdef NOTUSED
> 	static bool_t check_rpcbind =3D TRUE;
> +#endif
> +#ifdef PORTMAP
> +	bool_t portmap_first =3D FALSE;
> #endif
> 	CLIENT *client =3D NULL;
> 	RPCB parms;
> @@ -884,6 +888,17 @@ __rpcb_findaddr_timed(program, version, nconf, host,=
 clpp, tp)
> 		parms.r_addr =3D NULL;
> 	}
>=20
> +#ifdef PORTMAP
> +	 /*enforce protocol version 2 if file exists */
> +	 struct stat fileStat;
> +
> +	 if (stat("/etc/netconfig-try-2-first" ,&fileStat) =3D=3D 0) {
> +		 portmap_first =3D TRUE;
> +		 goto portmap;
> +	 }
> +#endif
> +
> +rpcbind:
> 	if (client =3D=3D NULL) {
> 		client =3D getclnthandle(host, nconf, &parms.r_addr);
> 		if (client =3D=3D NULL) {
> @@ -943,17 +958,25 @@ __rpcb_findaddr_timed(program, version, nconf, host=
, clpp, tp)
> 		}
> 	}
>=20
> +	if (portmap_first) {
> +		goto check_address;
> +	}
> +
> +portmap:
> #ifdef PORTMAP 	/* Try version 2 for TCP or UDP */
> 	if (strcmp(nconf->nc_protofmly, NC_INET) =3D=3D 0) {
> 		address =3D __try_protocol_version_2(program, version, nconf, host, tp)=
;
> -		if (address =3D=3D NULL)
> +		if (address =3D=3D NULL && portmap_first)
> +			goto rpcbind;
> +		else
> 			goto error;
> 	}
> #endif		/* PORTMAP */
>=20
> +check_address:
> 	if ((address =3D=3D NULL) || (address->len =3D=3D 0)) {
> -	  rpc_createerr.cf_stat =3D RPC_PROGNOTREGISTERED;
> -	  clnt_geterr(client, &rpc_createerr.cf_error);
> +		rpc_createerr.cf_stat =3D RPC_PROGNOTREGISTERED;
> +		clnt_geterr(client, &rpc_createerr.cf_error);
> 	}
>=20
> error:
> --=20
> 2.34.1
>=20
>=20
>=20
> _______________________________________________
> Libtirpc-devel mailing list
> Libtirpc-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/libtirpc-devel

--
Chuck Lever



