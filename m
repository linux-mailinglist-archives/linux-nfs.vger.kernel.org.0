Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7A666902
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 03:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjALCkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 21:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjALCjp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 21:39:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB74858C
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 18:39:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C11cMg003822;
        Thu, 12 Jan 2023 02:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=47xsffyYp1u8OiVe2yRxEmCpcADzm4fO7eMxPMzRr5U=;
 b=qoYyoRG4RONHUiBRKcyFdA2BhL7l/TCr9xutKN3B6voS5C00M2w4Zzeng045MvZKwxS7
 NlDgxCIHwGv0kW7mKFN/HfhKT4jlAJZDulIHH6ZcYLgjnTMuBW3LBfMTzB7jtmVaT1Rr
 96TUfRhQWlLcISPDu7hY8e6u7hrIoPPkTRGx5Pu7o8z9ewe2IYhbn/nnUIBDz63AI0wX
 p3nAILwoV6vohLAS36MnTDVEyYrlInSiRjCpd+HQLFrocQxdFh8yRLxWj6hP8SG5c0lM
 1DPLNjVI8mst/g9Y3tpp9heaXWUyAXU7dstGmlTrM82XvEChRkaH0B6Ibg/CXAgPNFaT Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btsc7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:39:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C0a89p016100;
        Thu, 12 Jan 2023 02:39:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4q405f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLDWikxC7tkvV04ZkGulBar4/WmkQltrBzp7lIcJm1tRLUGbKHCu5vecSWw1nh/wXjGEM9edF6/gExlzvW8G/Gh/CSGjWCLxL6rzKuZOVEDXfrPhaWfeUwMRpetBcluznjk3ljdjKj2JZvNh3ehBV5sMuLgr8I3z7/saIu1viDuhP7ZByxd2WnYEpGcr9ysKzeBxBexOrho8D4aep25DkViWDa9up+fXvkx52gNB9dyRD35JHzss7AW2/cLOl/PtEJSb6METDRVWKxYwwnpQNIen3d9Ha7B2VN/K/3IPKPVVba7dmYtBQaXVJ3/smgerR9uez4TTxriinaifBKXjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47xsffyYp1u8OiVe2yRxEmCpcADzm4fO7eMxPMzRr5U=;
 b=JNB7EpVf8Dz4beZ+CogDH0dhNVcmUZWqlw5rmdQ1NSqxTnOtl1bU/HfB9LEHU5qK/DjV/6NwFzQfasjmgdo7vHvlfo1Xwt25raWZnbQgjh1MbpYH6LzLjzkTZpYS6PR3NoLYjfOlKQbXIM+8c13KQWyeIQ33Nbg0CFQrZkoimJdgxWtvbCyLHCZiZhQSKJLlYPnsyqURxSeRZiexBc1zMWDlw/1WK9AaZNBXUAtp7UbU5tJeY8I5uJvOwj4zAQPcAo25bJcw4MAGTVUll56VxSLjP1/xrY02LSeJIIlC5up/MN0JczpIUDM8CXREbYnGUGnoRnFGzcDvOg3uO8APlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47xsffyYp1u8OiVe2yRxEmCpcADzm4fO7eMxPMzRr5U=;
 b=tX5zJ2wlIi2Rmxz2fwyZC5wm3Ke4RqHhmuJWZi3/oHcL9v3vDbJCwDtqvs/UjNyjY/opnsZFnr3T5HQwz87awCCc75nMTjPWREytPVSiG/l/etifF8BAZ02iOuN3uU/0hZMPbCSkBd9uqExMM5bSKWoca5u4UonX0yjyP0M2P00=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4233.namprd10.prod.outlook.com (2603:10b6:5:213::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 02:39:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 02:39:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: replace delayed_work with work_struct for
 nfsd_client_shrinker
Thread-Topic: [PATCH 1/1] NFSD: replace delayed_work with work_struct for
 nfsd_client_shrinker
Thread-Index: AQHZJhnRQiYIyIlXYE21938HiXynGa6aEgIA
Date:   Thu, 12 Jan 2023 02:39:34 +0000
Message-ID: <9160FACD-7A16-48BF-B4E8-F782566DD837@oracle.com>
References: <1673482011-27110-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1673482011-27110-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4233:EE_
x-ms-office365-filtering-correlation-id: 6b20ba61-8dce-4d47-0f93-08daf4463db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcQmybIFQXjAyApMyWkeJcWAswqVdMX1i0bA+A+DaUGkqTebqYJUMGmxN3cOwoDNIjMNROIlXXtDcPIP3/KJo9nij9nMV7Ol8hy1gjNRHAww+UPPa5xTbJuClw7fxiBzFjPHI52/sJ4KCC/4IzofXXewnSOjlcyi7ufmp5tf2UnEg0Cj7C1cz+Mq5uyRhVZJJK1oCaDftdjriaut5B60F88ViNQPv1PMbYwchtA6w3U6vP0ESibgZwPUMTp/yYhvLLKW5T7/B5GsMSn/jAzlEfhNP+kYSMlX8guq+z6liA1h1y1q6cQozCu+yY0Jz0OEw5cbRUJORajjiacnCU5fKJO1/VABu9rPPLJ9M1r7LvJyWQ2BKqrH4bWpBbdsvdt5jyq+ixauWeRWuDeGtwoaJxBBrLeBWfwKs106766lNb+JyxVkkfnB8c27tK61S7SUuF2xCV2aq0Eof8Gg2qWH5pmQZgGvKmpd0Ed83vcWwbem3+TRC/GpqD327t6fsHAKXaWGkZaIe9MVTDL08arqeQErYdawp5CnE9d0INx41d+9Oz2h7dJhDJrLy9bIME4W7pNNhGrZfcMAL+buwz8RR9W4z9MmaT+pQJw5U4OWmaROCuHHVw1ItA4B49P5e3+Jyhrpu8YTo2LNgnZNOKrfFYy1x5umTvpSDgDXDDbM8JkF3JBoto+0GHjpTNQIlxzs0uheVjjl5PDxjIU4/h7qEFyzywI/MfH/w3aUb+892N8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(86362001)(38100700002)(71200400001)(478600001)(38070700005)(6486002)(186003)(26005)(36756003)(53546011)(6506007)(6512007)(33656002)(41300700001)(91956017)(76116006)(66446008)(66556008)(5660300002)(66946007)(64756008)(66476007)(6862004)(6636002)(8936002)(54906003)(83380400001)(2616005)(316002)(37006003)(4326008)(8676002)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+iJU1Wyof9nOD13QlBuig0/ev8aTRApY2CG665bV6Qg9AFZwPcwdeGahzA87?=
 =?us-ascii?Q?FJSeCafJ97WgWX+Qmy180XDtG35uKxOjM7m0HliTg0HJF+wTantmYCgJuxlQ?=
 =?us-ascii?Q?CNJ0GkbttdvUAgdDXUYvhlvXG/Uz3VJHec9mbO80Ni1g1Kxe975mUwFhYZt2?=
 =?us-ascii?Q?R3KDQfQZvlVvmbZv7q2OUuigQUBC46Gg7df34u6jad8aSIDedXmRJl25wYxM?=
 =?us-ascii?Q?OXsNthqQzKHq/i9eUM6FHx175v4dnujknuo6q5WCXf8t8Ck+n19Q7cczYGdD?=
 =?us-ascii?Q?bOPUp2aH5B0FFnABfdyR7HfbFSV5RV9OSD+D+A0ygVbIukTmXGcCmn+3FPWT?=
 =?us-ascii?Q?PKckPyvBgFPMwSF7PYcH7EhWpOPXcqw7aQ+ROEC9xe0vBu0LUZ2rReXELRrA?=
 =?us-ascii?Q?7VwO1i3A7c8G9mOKyd4dDWfmCuS+Ywqu6ijQU3DEdmgxjLv1wxmoY3UWuIui?=
 =?us-ascii?Q?BUqUBTSYyeWQgBZE/+b1FquOjZH/3rGqeILcYI+cfwrARaxFDRTctu+H9MGl?=
 =?us-ascii?Q?t77iey6OsXgHifpRhwhN6uRqQavGlN6q9rf/JtiRT0MZU+qcGeeAtkhYLepO?=
 =?us-ascii?Q?FXKgkFwy3pn1sS/6X38WWBhelZNDf9CwcjagqrXsVHsGCfCFNAwUVQKpl7wk?=
 =?us-ascii?Q?Ah0ETutj3XXZoqIC/TZoWGPvTyw5vwF93bWMm24t5yUZSyWepMIGzXfOanza?=
 =?us-ascii?Q?/aoy5i+6EtaZj8+awsg57QaHcFp286/pV9wBhngqNASfRP6anOLIZZdN4MrI?=
 =?us-ascii?Q?LDJEBKbwVzBnAr/n6DC4MzMisoTD2eaTjTsv4DLGBdZ/nUyYrdXVy9hEaws/?=
 =?us-ascii?Q?hQHloyO6CqMj93C8kl2WBRvhRgbW7WSofvWtlKHuLQ7qGIHXiMTGw3ILoTv2?=
 =?us-ascii?Q?IYHCkKnm5YwupcdbY4gQv7Is7Qxqx3ggdlQ0Ph3YZDTQ+uw2e8S2RYY6umqh?=
 =?us-ascii?Q?8BSNmmrKZIfRFVsvz1pioDkkJjbwKA8LPTE6lOujUJ6QTw71qAAp15GneZ/t?=
 =?us-ascii?Q?ovpmBsdCvtLKClRoFt0tJCUmGWuSCJs2f9IVHGNkXcz8j/A78+oQlQwGares?=
 =?us-ascii?Q?NtuxuYP3rDiCrQcQir8j7cDsYd4ycxuMEqpUnFWDU4lEMxNlAAkGDXJUzO8/?=
 =?us-ascii?Q?ltUlHK5nuRe2Xx4eoT8GJPRzt5V4IjmynFWZFmT/Wqa/C/USfxWVpOoTLk0s?=
 =?us-ascii?Q?OkXVy4m9K+JhSQZe1+acu93a6Av6rT0HjE53BJ0WzOOngsBFIvPBaGPThXL/?=
 =?us-ascii?Q?7DaTbXxdObh0SQ/m++4mE/td5nFMW2NAThgekgNy3/lvB/KdJ60rO5UHlHpY?=
 =?us-ascii?Q?MePvnnsrLFBd2I4EBbRUCUsBgS4u8scUC7GL/stMfX7xVVGv73RGknY4ZC42?=
 =?us-ascii?Q?MJOXL0xyVaewIbpbCBpANjMbkg4XryzLAOQagojPkc4eZxiNl4F+dpNfuzRA?=
 =?us-ascii?Q?xfLYoOhDcl5zZVIz77G1mcnBkURQiWkrLV2aNF0iAGVG0wwIglTywFRXCPz9?=
 =?us-ascii?Q?AbV0TQVDjZn12HPyqb6iT5MsvF4W7UyY4AVh9WULH1p/wv4+Knz4wZ+Aye49?=
 =?us-ascii?Q?b7Y6WV7AKgBj7f4+51JrJ38zi8rao1vL1uBvVoBlCxlqHc0Cib6kyz+cewx0?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1192C70BC045894AB7BCF1753A3B77AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nir0lCajeF4MmxTVjVBGexGQuNgap+G8s8b2jZoIhhG8yzkyY6CGHfcFb8taj4nBz7unUDlJ4MeRzVatEhwKkV3JUp9AIgUY/7zBE3lk0GnQBavy9KAoAVM0R4VjIGXyzqSXH2HT/uKjDbhvaROd80JgqR2R6/iDu0qZ+VwMMSWjmx5t4t/JHLbu+zOqVw8hotk3EUKD+nFmj5erKRRtqGf/h+J0aMRzO4OybC4xX1Iz38oMmHdTHdZNUH/9jkCVjtW1HiGok578mg6kaCWXu6KnatqxbfWVXW8hmNvWadvr13lnJOkzVzk159uJqp8/zCeuBwzEt8CxxjfEF/u8okzhrAQdnPZ5PaPFyh+fD4vIFd1JLIQyLdvR7PqLftiywzILKbcUYskUPqJ9lSVCbLiobyzXg6ZZ8/UI2QrnyBssv8Vlm00t0xT0lpiLpELvMjFLm5OSEOvFMSDoTVoxS9gBk2Vuv1o3X4FFzsfcSOTs0PG9wkKNfOZa4GL3XbU3e/WQxKgUKXNlMdEhYuuXsf8EfVGeoEaA8y1BiBM27N8Wby4L62BGav70Ym79GUVcqMmT+NTrt8ULsRP6oVh3wlc95zbUM0IEcgRtN+EY/3fdFRuF7BgzsZB1ZqCA/OGEbDlVB7fLE2ODhBiywOcOhcdWCt68slV0GSdpOi3w3vVzUDiQogjW6nwzKiQ5uzLFBptgqP5+WypU3NuvlO9uZWtcudcCC1rqg+IGiE4xePhZ0Zm+sSSiM8ltUoD5HxpS+p3/n/MOf4Vi8rHSIEMgKTkHzacZwWoWea0+nufs1tA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b20ba61-8dce-4d47-0f93-08daf4463db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 02:39:34.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IgOLI2Rx08KaSeQ8ZHIvappE8VEnfJ9ofui5JXYSYWI2DWXrrCh+Tcs6AiVNyZqD9ucWuwCdvveLPRYrsXpEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120016
X-Proofpoint-GUID: 1RSVR2CDTpDVdnNU2q0CUoXL0wNqeu_J
X-Proofpoint-ORIG-GUID: 1RSVR2CDTpDVdnNU2q0CUoXL0wNqeu_J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 11, 2023, at 7:06 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Since nfsd4_state_shrinker_count always calls mod_delayed_work with
> 0 delay, we can replace delayed_work with work_struct to save some
> space and overhead.
>=20
> Also add the call to cancel_work after unregister the shrinker
> in nfs4_state_shutdown_net.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

The missing cancel_work seems important enough to apply to for-rc
instead of waiting for the next merge window. Thanks for the patch!


> ---
> fs/nfsd/netns.h     | 2 +-
> fs/nfsd/nfs4state.c | 8 ++++----
> 2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8c854ba3285b..51a4b7885cae 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -195,7 +195,7 @@ struct nfsd_net {
>=20
> 	atomic_t		nfsd_courtesy_clients;
> 	struct shrinker		nfsd_client_shrinker;
> -	struct delayed_work	nfsd_shrinker_work;
> +	struct work_struct	nfsd_shrinker_work;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a7cfefd7c205..21bee33bc6dc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4411,7 +4411,7 @@ nfsd4_state_shrinker_count(struct shrinker *shrink,=
 struct shrink_control *sc)
> 	if (!count)
> 		count =3D atomic_long_read(&num_delegations);
> 	if (count)
> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> +		queue_work(laundry_wq, &nn->nfsd_shrinker_work);
> 	return (unsigned long)count;
> }
>=20
> @@ -6233,8 +6233,7 @@ deleg_reaper(struct nfsd_net *nn)
> static void
> nfsd4_state_shrinker_worker(struct work_struct *work)
> {
> -	struct delayed_work *dwork =3D to_delayed_work(work);
> -	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> +	struct nfsd_net *nn =3D container_of(work, struct nfsd_net,
> 				nfsd_shrinker_work);
>=20
> 	courtesy_client_reaper(nn);
> @@ -8064,7 +8063,7 @@ static int nfs4_state_create_net(struct net *net)
> 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>=20
> 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> -	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker)=
;
> +	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
> 	get_net(net);
>=20
> 	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> @@ -8171,6 +8170,7 @@ nfs4_state_shutdown_net(struct net *net)
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
> 	unregister_shrinker(&nn->nfsd_client_shrinker);
> +	cancel_work(&nn->nfsd_shrinker_work);
> 	cancel_delayed_work_sync(&nn->laundromat_work);
> 	locks_end_grace(&nn->nfsd4_manager);
>=20
> --=20
> 2.9.5
>=20

--
Chuck Lever



