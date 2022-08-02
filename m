Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F69587DEC
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Aug 2022 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiHBOKZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Aug 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiHBOKY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Aug 2022 10:10:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1775A634E
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 07:10:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272E5cDO018838;
        Tue, 2 Aug 2022 14:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=S6rfB0yMnLbCUIBsCrygGxGCjOHKzyFnOKXmbPxafsw=;
 b=NNSnGf8QFc5HRE+1oTjIXD78XR66VQma5rJmHimODHAfjB/HwxEchCFuqyF+QztmFXki
 MKR1812l9uitCnGCmN8CW+yXKFgOwCsNRE4qbEkveyt1UhpMHig3pI+4ie63T7cr1ZyK
 ZawHqR2KMr9epTlENcwdjQZ5BEKY/YBpUk1WAdJHCQS1wlCXi1QiwahhS1Xn/PBwZoBv
 DF7nQghqY653Ex6jelAxeIKoZb2hLMtaWCv1nSzPkW7MAGy4hXU3TG0gxFa97a9ar4/v
 Hc016T6wNmzIjyU2Peby4GOV+jJhiFXDIDZcAqPcYMopunfISl2iR818RAlxc40LlKgb GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2c6us7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 14:10:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272DeOYC007412;
        Tue, 2 Aug 2022 14:10:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu3236ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 14:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTIfFvsio3EQHCrt7pjo8rQcqmiowPTy2wY8kjwi0ajbwkPJi5hDBvoM9eUm3oX7BjCsA6SY+VTwzZx+9eQo3tAx9o3MZewwuGRa02shtc3J0zhjbssC0YNIglswHH79pYxexbV/pM2tOaHSRtE0lSj6vCuvZaFGVfz0t7o4ce/semlp+W3DO4br3abzfB5cA5lZP7MyBQMizN9dot0ISNmZjlyS18Dhdv1t2vqP918Tr+kASWDEmeui0iVr8AuqnwM+HCezHh141QihnS6M9gnt6JB7kkS0k5IVHArWuFk0XBQYc9zlAMT7mf0+n8c1/bPoD9HwgLruWJnBaPaZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6rfB0yMnLbCUIBsCrygGxGCjOHKzyFnOKXmbPxafsw=;
 b=ULdvTEmNZkn5+Flpyizf9gu44NntQ5VxtANVL2Cb0YABnojOGp3E0ZTpWMUO5lS5E70K3kTYjNIdV/Oqz7hqYfOzwM08pXiEcmAW/E1Un5Xo43oOaUhN/+dqehPAd0+HdHz6nrQmQBTf+UG1fz60IzAGqqkuCBf65xZuxZuH+RRcwnmMNH3LxN/jY1kvYsUy0HK1Sf49/cdU71Mcvk7VoI3AogMp1lBhQSdtSfjBxo0ETtZM0ve56GHhVEKv8KWr/QpIKJQ/HFu2/VAxPASfT0teQeVtlKcxz0uE96UA/yN4tLh3nQzlFrA2KpL1I70JU5a3nQnePYK1F1IkoLOhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6rfB0yMnLbCUIBsCrygGxGCjOHKzyFnOKXmbPxafsw=;
 b=nqu/rUpozz8uS7ifyUerg4jgjbADjZC3HOKIEtukxW5B97YqlyJag0AetD/3OeolhMiA+R+9N4RDcPGMa/BfIl7PrjXSeSlx7VRAaTwi8gdaGIEE/9Ep3evENs5d3TH0O6i8Oa/w4I6xA7MUG+alXxvXrT19Vqmj5n0SWdk4WZE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 14:10:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 14:10:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jan Kasiak <j.kasiak@gmail.com>
Subject: Re: [PATCH v2] lockd: detect and reject lock arguments that overflow
Thread-Topic: [PATCH v2] lockd: detect and reject lock arguments that overflow
Thread-Index: AQHYpeDywRmd2Ah7M0OUhDyIIRvMH62bp2IA
Date:   Tue, 2 Aug 2022 14:10:09 +0000
Message-ID: <D34C84D6-B1BA-4200-9879-B0AD6CE8AB00@oracle.com>
References: <20220801195726.154229-1-jlayton@kernel.org>
In-Reply-To: <20220801195726.154229-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 554d6966-0654-4389-4d13-08da7490b53a
x-ms-traffictypediagnostic: CO1PR10MB4643:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/1hc1M6UaEhHLP73D/uAmKlxU8jx61F308+ZC2UmiQlrVw6Bgb2brCCFDLCNfrpT7YkJYuFEZyKTfdCviOSdicoV25dz1brt4cvcOwr6mW7C5He7hk5+UOWZyiF4dHP2b4QG+VTf6+K1CIjfnLKbwk7BHJz45Y6PpWsWlU4ObFGzTyUCGcXRqvEQ1tZkF0pPVh+TkAoTCepzJQWY+K09NhPzPNay/qoMSPMt6JyTUZP85b0QL80QqA3UtttRcDEuwEcxj9eabrFCEa4H7ZrrpkbpncXaX3mRv9ivxdQkVSQJcNOZ0kXNrtIUSXnYLx533TXoVA7vHLn7HimFyQVG/C5u5bXNVD5IotTE0UYrYnK9ucJt4vZn1ixkbpscrhPs4fIMEBiEap1Qjdo8JU61dNJFGF/1Z/AzKBKRToMpMGSjjUQ9/YEnVBaPj4fPe1F6VnYPRjsJ71xrrzHLmtsFPZ7I+bv0HxqNx1PeFg5t2q3yKmcDnzIP+fGyLUJAlnllC1A0x9dr1FefJEC6LToO0CSGc77K65ERm7d5JKh7SqDb5SxwVX5SHvGu/487wKRLkRliYqvzWBPlp9ZkrX4uOdF7iaUsJpHJyZsle3mHTCHfAgtxqMQ0bLrHRLdtUej+CvqPs8WgHGp4LbyV3fKvDaysYA8KzZch7hJI0/DP9vhXxBZXBNQnxZ/pyLweDWm+lyYtpc4Ulins0PYfak2lHMO/LFARQ9wzBSu/2VlJhnLRjPE/cdC+2j36QVH+dlS922n1S5RT5cAKLpV1Caizo6lAlzd9+iiiCUxCbo0U4kMVqCNtMnwkg5BHG0NQM67Iph3TBeJT0Kx5VLLyHGJQAfmdNktQkeMzJVwRkKojinkOKJZva7jv6WpwPqkAPFm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(39860400002)(136003)(41300700001)(6506007)(6512007)(53546011)(26005)(478600001)(54906003)(6916009)(86362001)(71200400001)(6486002)(966005)(316002)(122000001)(38100700002)(38070700005)(2616005)(83380400001)(186003)(4326008)(91956017)(33656002)(2906002)(36756003)(66946007)(66446008)(76116006)(66556008)(8676002)(66476007)(64756008)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qVxTdJ9RPZ/aCa5GYG6RrvpPFnnXb4A9x9v/ETPDfSAzbIwwQzbYaCCEfnZj?=
 =?us-ascii?Q?ailBSKPSQi9HO1+MAeUTHo9x+g3yCpdExKnVNq3ByUEWCZGOc62PFgdy3z93?=
 =?us-ascii?Q?AaZChr/5u530A6OkQL5u2BrRSNV7xSNCRakJFDUQabAjmmuyxOLOYbHuLUqz?=
 =?us-ascii?Q?J1q3PaR1rXyNMJ2Pqw4fb/J/D3vtSVxc1cO0/iVRCuQMHZzyI54VAOfl24WO?=
 =?us-ascii?Q?Pn6IkF1RA0RPQaoLklbL5tiRD5uNoSsk+7KkiwL0sLb0sBYoN1moUUlQcu/a?=
 =?us-ascii?Q?GfxdCtixzWEzgT5/1OP9bGegEW8EmCthdOX3ykTsJVxicTt41rr1ZVzw28lN?=
 =?us-ascii?Q?LOFXR4w0icDVKn1BiMvoXfw3X/AfEp3UtX3QoPriqJhZrfax7ueRC370PNMI?=
 =?us-ascii?Q?cQFvTlUQ6M3z/0+MoTu1wrFl+DMdMUoel8/8hYS4smKNGOCn4+mMxg/A9LSX?=
 =?us-ascii?Q?rg6011ecftXM8zVYI1eYDhTU67qmJHeYljRs8PzySamIp4atIWNPjh99j9js?=
 =?us-ascii?Q?dqpHdYJpJaXFL4wAk22kFwTPTFNrjjCdnnc0FmSyqdzduCLtI90RrkmDikH+?=
 =?us-ascii?Q?gst05RrSLanZjB2fVluWYpZQKD9343ukm9iMGVqimMiiPcg/Y21U9tHlzZIJ?=
 =?us-ascii?Q?3PMjI8WBqSt1CRernZPrYwqfZddzWYVyu/4MzlWI1jV6K1UpeBE0JYcneup7?=
 =?us-ascii?Q?mCsbVlp7PLw1o+qfhRbwETLA/NI7J74tBhQpiFIW/DoD8RrNild8N3QdgvT1?=
 =?us-ascii?Q?BlKSsmMMohttpqXX3XDnHMoHHFppVJXvyIxKBmT+cmswKTYcHXoPfmQan2dS?=
 =?us-ascii?Q?A8ml7pqrJFtQgYJM2bSlzwvZPHSf6oNIkSLUlnI01ijczCj66wkRhGLSBkny?=
 =?us-ascii?Q?Zdxpx1Gx/tsuMnSoUNxmra3/sYIrfxJb/LVue2i7r3P6RJZh4GbUSwssr0HA?=
 =?us-ascii?Q?wSbHlMCBZRVc59CSslyyttVA2ZwlhwjYI8wQKx8ZkGbbNcm2EhaZ0dw67fxa?=
 =?us-ascii?Q?Is1439lQZF5j36B0ZhkySA/8fmAvDhWqSD5Zsajj/qSDYY4CxV+ImBjhOhcm?=
 =?us-ascii?Q?9gVvflo3weIqnpM046m921uVxegBi+uc3Zv7KXpHEINH9aN05mfKm9YCkJ3p?=
 =?us-ascii?Q?lH7qUZv17uyoMisVbpgW5mp+fsAOAYpBDd0HRmui6lXmTB4RZcUN9bs0u+Ee?=
 =?us-ascii?Q?i24MLDrzTNaQAGsM1m47WhQHTRENHI3b1+7vO+nG6DlMZwCZRHtWNHShJ2h9?=
 =?us-ascii?Q?Vf0jmMT/PLLuDpKh1pWfI2t1S8a0fgtULMtpEEOiE4l+oF9o2/8YGtUfelGL?=
 =?us-ascii?Q?puBtPbkbbEqMWsen+FSe6ZNh1XcDuGp/AhbAQ4OJA3E71gDpl6tLv9ClqRUy?=
 =?us-ascii?Q?pYtg5tPNIkL1xUnBhsma5pm5UUjHETMSHHVpn2Ns4G3hvCdrYZQuT/beASFt?=
 =?us-ascii?Q?sCcvvYDKpL9WBG8vnQaLpAc5M3CedBlx8ksUyzE8jiMjVk+7GMO9VyFOJ20B?=
 =?us-ascii?Q?5EgCOWIqvJv2QBcUHo939wufcYXZXOPRXSI2RK+QqXblDAhpcrOsqQlU6ZKv?=
 =?us-ascii?Q?YLumEGP9G5CLDVTLzMjmz2ZbSjRZFDcNukO7ZMTWwdbybUkr5cqT3wVHtrMZ?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33EDD8B759F0A44BAA900679DAAD37A9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554d6966-0654-4389-4d13-08da7490b53a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 14:10:09.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jr30wHJz2McYubg0S4A75wcSojfHq2rjfqAR8ZA0K+6QtCmB9Q+T5FiTIJazSZ7ZFX3Mzle9oxUiCHvWbP+p4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_07,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020065
X-Proofpoint-GUID: jFmAOXqhExUjhaihW0w3uFe8vq6ddD2q
X-Proofpoint-ORIG-GUID: jFmAOXqhExUjhaihW0w3uFe8vq6ddD2q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 1, 2022, at 3:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> lockd doesn't currently vet the start and length in nlm4 requests like
> it should, and can end up generating lock requests with arguments that
> overflow when passed to the filesystem.
>=20
> The NLM4 protocol uses unsigned 64-bit arguments for both start and
> length, whereas struct file_lock tracks the start and end as loff_t
> values. By the time we get around to calling nlm4svc_retrieve_args,
> we've lost the information that would allow us to determine if there was
> an overflow.
>=20
> Start tracking the actual start and len for NLM4 requests in the
> nlm_lock. In nlm4svc_retrieve_args, vet these values to ensure they
> won't cause an overflow, and return NLM4_FBIG if they do.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D392
> Reported-by: Jan Kasiak <j.kasiak@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've applied this one to my private tree for testing.
Thanks Jeff!


> ---
> fs/lockd/svc4proc.c       |  8 ++++++++
> fs/lockd/xdr4.c           | 19 ++-----------------
> include/linux/lockd/xdr.h |  2 ++
> 3 files changed, 12 insertions(+), 17 deletions(-)
>=20
> v2: record args as u64s in nlm_lock and check them in
>    nlm4svc_retrieve_args
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 176b468a61c7..e5adb524a445 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -32,6 +32,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct n=
lm_args *argp,
> 	if (!nlmsvc_ops)
> 		return nlm_lck_denied_nolocks;
>=20
> +	if (lock->lock_start > OFFSET_MAX ||
> +	    (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lock=
_start))))
> +		return nlm4_fbig;
> +
> 	/* Obtain host handle */
> 	if (!(host =3D nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
> 	 || (argp->monitor && nsm_monitor(host) < 0))
> @@ -50,6 +54,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct n=
lm_args *argp,
> 		/* Set up the missing parts of the file_lock structure */
> 		lock->fl.fl_file  =3D file->f_file[mode];
> 		lock->fl.fl_pid =3D current->tgid;
> +		lock->fl.fl_start =3D (loff_t)lock->lock_start;
> +		lock->fl.fl_end =3D lock->lock_len ?
> +				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
> +				   OFFSET_MAX;
> 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
> 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> 		if (!lock->fl.fl_owner) {
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index 856267c0864b..712fdfeb8ef0 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -20,13 +20,6 @@
>=20
> #include "svcxdr.h"
>=20
> -static inline loff_t
> -s64_to_loff_t(__s64 offset)
> -{
> -	return (loff_t)offset;
> -}
> -
> -
> static inline s64
> loff_t_to_s64(loff_t offset)
> {
> @@ -70,8 +63,6 @@ static bool
> svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
> {
> 	struct file_lock *fl =3D &lock->fl;
> -	u64 len, start;
> -	s64 end;
>=20
> 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
> 		return false;
> @@ -81,20 +72,14 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm=
_lock *lock)
> 		return false;
> 	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
> 		return false;
> -	if (xdr_stream_decode_u64(xdr, &start) < 0)
> +	if (xdr_stream_decode_u64(xdr, &lock->lock_start) < 0)
> 		return false;
> -	if (xdr_stream_decode_u64(xdr, &len) < 0)
> +	if (xdr_stream_decode_u64(xdr, &lock->lock_len) < 0)
> 		return false;
>=20
> 	locks_init_lock(fl);
> 	fl->fl_flags =3D FL_POSIX;
> 	fl->fl_type  =3D F_RDLCK;
> -	end =3D start + len - 1;
> -	fl->fl_start =3D s64_to_loff_t(start);
> -	if (len =3D=3D 0 || end < 0)
> -		fl->fl_end =3D OFFSET_MAX;
> -	else
> -		fl->fl_end =3D s64_to_loff_t(end);
>=20
> 	return true;
> }
> diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
> index 398f70093cd3..67e4a2c5500b 100644
> --- a/include/linux/lockd/xdr.h
> +++ b/include/linux/lockd/xdr.h
> @@ -41,6 +41,8 @@ struct nlm_lock {
> 	struct nfs_fh		fh;
> 	struct xdr_netobj	oh;
> 	u32			svid;
> +	u64			lock_start;
> +	u64			lock_len;
> 	struct file_lock	fl;
> };
>=20
> --=20
> 2.37.1
>=20

--
Chuck Lever



