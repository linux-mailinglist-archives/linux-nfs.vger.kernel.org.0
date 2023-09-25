Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31F7AD99C
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjIYNzC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIYNzB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:55:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DAA9C;
        Mon, 25 Sep 2023 06:54:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PDkp36031077;
        Mon, 25 Sep 2023 13:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=qTlPvcGpzM7gl5t3cdbCIN9uSnBGMNE1s3Ncp03wMTk=;
 b=s8FZtWccgNPZTunDNq3J+9TGYR14p8ZNMihVveOjaEHIEp4sup5FuFzb5zjuI2TRbdf2
 7AGHvbzJaL+at+JejC+nJNr5e0WE+CyLuxgSVfW4Dh9xFR/IXf9QZwRGTgDMW/Pn2kkw
 mBhyKepX1pOkfclfAOCFTmbxDOOaoilPEoeQTqKwX0L4MVxSpIdSKyc7khFzqS6wGbte
 Lcj6UDhX8CziSRujjDlsWEBD3ShIGHt4mgMjktt8XVVtnBIl9Zr7owgP9PgcpzuZP+oy
 oeCf+8onlH/utq8Qd3/KHwNSy7MjAeky6wILBCEHeYb2OCtOyhkGL8gs3XkpZe4KVXbu sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbbpy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 13:54:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PDpWdI003243;
        Mon, 25 Sep 2023 13:54:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4q20a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 13:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA/WhygsDIVrF9lZ5pEeoFdWhe1/eEOLs1kLrgFnDGdoF0u0LmHdKRv3O39qhECLXNypA4fhBjOVoEB7NNk24vplHqg6oTztmeZGP52NTUZGwaiyb+NJcZ7Hz9etlAT9liIUBh7rPDHhTs1qqK1xLI3wfzZDRQ3E0EH5DIZILdk4amC5gYb43+Y30g/WUd04k7mVGmEWhSJaiaKuXm0o6pMGHj4ZgNqM1gsYdmyjBFxGQrCoJ+VEPLlRIWbvmlOTxIdEPSUZK32fJCKLri5iZ4V7Fk/vp7nsylBUniqP5GmR2SgaI6XoPjpJWvHCuQvOfhMT6z+6Vv4KvYVd2nPsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTlPvcGpzM7gl5t3cdbCIN9uSnBGMNE1s3Ncp03wMTk=;
 b=Pl0qrCB4du91Eq6kAvt1sApdjYHZg/tvt30XkTKsbehQenWzqV8nbwYANd4lTxA//1cc9tvbiDkyaIvfzqHPNQ0VJPCdwEn/EO979u8IwrGxmAcHm+Z644BuO1pFxG2zTH9pJSETipt7PQMwJJxA67vFm4YU2rOv04F7nxRtqvVupex8ZCyZEDRqMJMWbOtI7G9lmFdc7YCA+bZxBmgC0wGLe14skDF1b8uwgEqzRaWLVrThtouzUUs5GYb1bpac+rPGx3rbzEJjdxYWrU3VH+2qKkMq0aeeecE/ZDLs3Q7Xq9Ykhw59ljZ+M3QRBlUHnIZYHGVboRKIK4d2g0aGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTlPvcGpzM7gl5t3cdbCIN9uSnBGMNE1s3Ncp03wMTk=;
 b=s5LgctFgpyLDym3yYnIKQuuyQMryvZQeJVzkU4EnKHpGMwNVRUzuguSDPnSkDkgXHqJCnaGGMR1zMqZ3wVwmrgyMcyeiLA96ENCMYk8Okrs5A+BJe8qb+kAyiTSkPbQUy3Kyn/lbilHsjvgDNX/7DPybKJn5l1Doc8IwwoT3ODU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5993.namprd10.prod.outlook.com (2603:10b6:208:3ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 25 Sep
 2023 13:54:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 13:54:40 +0000
Date:   Mon, 25 Sep 2023 09:54:37 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Message-ID: <ZRGRHbQ4w2hcEre/@tissot.1015granger.net>
References: <b9fefe9a15d8a4c5ab597489902ab2f868199365.1695563204.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fefe9a15d8a4c5ab597489902ab2f868199365.1695563204.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610::37)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f2a79e-4e48-44e0-ca9a-08dbbdcef6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvrpPD81gjIMUIBYax8OQs8mU+ZlG6W8U+L7NUuUfTVJV25adjWx7Fsb8u1jDh+f3cRFkW48wA/xVEzxpILi97JAAg0Trib2FGWTABoHOlVrHpUks9ZzOZRZ7fsRzTHgtMcuoP0IGm33cz2H1SraqiZek0T73YXiE7TMuf6yPh2yYbFFGLUyF00WyLugWeQ+3PHd9fl9rcpjle2dVNEFVnjkd2qPLwUrAV+DJa9Xz8kSA3r02JCGaG/SrekiiLsUTvheKaiRUAD4fog3+a6yM894+WLh19lGyE3FxGOiR5MZGg10/WbAxRKXUU0i9L6MYhGwZAnIhjD66FA9RFhmhdLeTdx5CQSQxPT6rxlna4mohejnOyZLAztkd0H1QxTyUQgpmji7awZAxsvE7CmuHWUW5nD3chPuKtFLilGykfQ9hHUolz/D4zzfHp+naWuSKJuMUSwcuBbRKT2YR33Bj5jqSH8gYahOupiUVzmiC0rgByk7o/+BkDyrtEX8KiHUugyL7WezS8dK0RqpZ+/Kq6BoZ1DKTkwLXpUTnXs/W30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(30864003)(6916009)(316002)(38100700002)(66556008)(66946007)(66476007)(478600001)(2906002)(6666004)(86362001)(966005)(5660300002)(41300700001)(44832011)(8676002)(4326008)(8936002)(26005)(6506007)(6486002)(83380400001)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/P5uF9lao/BDZY65O7qKYWQFPFSHIhiau8XlXVCCEjoBEOViEVYKlRQdII7h?=
 =?us-ascii?Q?DMzRS05tNxTk6JH587qTjjiVqh174UiAwuyaJKhIOFbf+Kl86qU3lxTGV0TS?=
 =?us-ascii?Q?nOPUHYLvLTHnqUxG2Xl3X45+KZ/yOy0cHdyzJiu6XDgbJgFBO3klccIU2fKL?=
 =?us-ascii?Q?gmYUATcHGglnSRf5UWw3ZyuWtqAoBwLN8MbwEggf58SdV7UuYqi7wwvnpXR3?=
 =?us-ascii?Q?6aYA24w8iR/4OD5WiGQuEthR1fQemwBG8oPbHvTWH9pCIYTF4GERXZeTkkZE?=
 =?us-ascii?Q?thxhswgkxsz5uzLm0TDNKdV+7UEtW92RWFkJeohlMB+x/li0Uh3Pe3ZaXOcw?=
 =?us-ascii?Q?YABwUkTmSDqCLPlz0dGffafX5VXRwlEbPpW5Jr+vTbuLqakduP1KcqKLPVBn?=
 =?us-ascii?Q?rVXQzkX2AGqlK/231ICP8PkieQj1y6mRDmHNkFYY0umqIZR4H/nPg0RoK7Tu?=
 =?us-ascii?Q?bTlVhYSkQhgtUaPRJtyi+FgmS/SeJhXL4FKJ0dKZQ7uhB7XA5ny3/NZMYfqv?=
 =?us-ascii?Q?MuDSHzgKNc27j0AKH+2uamQxb8gwKP419+yjUHmiWKFzx2Sn7h1DNLh68OKR?=
 =?us-ascii?Q?wdXL6at7XnQLOxvqzGmHJvthco8xnWJG9ms8bSFtJCt9hlMON1l3zS1KYZEu?=
 =?us-ascii?Q?EwRHSjnfP+xuLfcONvzYdB6wte0G/Q5ZtMeZnQVLZlca1ZwLQsDx3bmotXm6?=
 =?us-ascii?Q?zao95ctr/JYBHSju8uPpc+P3eNe97dy88wBWhiPw9neltEYwK0wukLDg8v4M?=
 =?us-ascii?Q?nkGkz+WBnPJvjYabfL6MgagzjUmBopgsH/PQIn4K+1SnC43mQbmAcTdDsByw?=
 =?us-ascii?Q?AfQD22UjxLDcIhujYE2e0J6ggXpVRTFUctbxUss3lmksel9/A2pfiyrgjfBC?=
 =?us-ascii?Q?tnMWqSS56ycVot5GkYH/Q7ehEcWYDSAwbK6JinEpKvi4tPU14XNNLZv73rFl?=
 =?us-ascii?Q?GNDBcbo6roVSA4cPtBIzvnUZl++6gO8i3sy4QVdeIvw9BNvHkMmjc/68nW7U?=
 =?us-ascii?Q?kPFhdldumhSvv0UQDBv+OhycE6wqS3NnQnSQmOZooFl9Xa4YrY+o3g+94+LL?=
 =?us-ascii?Q?keRdfMmmu2/RF95kIi5LIo07sFfNt0K7lq1NVXdFiRgk3l/wK3r+buiw5Hnd?=
 =?us-ascii?Q?+Q6LNdo2zNAEQnG9rJAEVili3dCw2PUq7a5JoaRpTUcEc/DluW31QHjGM5F4?=
 =?us-ascii?Q?8sDutIdut0NtL1ZINMpVJWta5ZZdU5BgmzWvpFprd6fr4JkOUgGrQYkulKJT?=
 =?us-ascii?Q?nzDuM3EkY5Y5rUOtf1Iu/N4623M41UArJtqDtyueXUeagvZlMGvX9hzQ3uOS?=
 =?us-ascii?Q?5bqd38WMGrae1yLNmjHxochP+6KUPpRrV1M50J9ciG3xmWRy7cbJg6mpZBEu?=
 =?us-ascii?Q?T2EKDErzi9BqSqwNdM76ftJudiOew0S8YWVzQ4JhD/jwXZK9qf1mye7gkUY9?=
 =?us-ascii?Q?1YcD0JlWmChwx6J+CsgmKvRkfwXsyAbIBlndEB7bvK4FlkxadBW0wgeHv7kn?=
 =?us-ascii?Q?UN5+/tAQYbaXCLB7nS6O3SYtr7GoQiDbY88VIqJo1AAqMBA+qFOVwx0fis9J?=
 =?us-ascii?Q?UyODnuZOH3T7MZLBxaBRDBgNKupMd0c5lsQNf/7b8/j12P0LKyKlK7UBGvcn?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 58mRIpiqq4SfPzLF3IrSElK3hDipnBtG3CWZzBopweN37rxek4qX3gjEkGJUWkh1n7EoJQNzNdFAzHWHAzvAz5i8Lt5Gkg7GABQ5kefSLm1IuzwYe91FWM0zXVvWeFqwwG8UkaBVSa7b7aCvpjQ+Dh9pmvAtHCbTc9tsQEGiakEuwad0b6e5IGkd9WYt09iI6Z5D/zCPwnh7INs9TlWUVD6UiaJFTTnhZQBq6M8axJhHtQa/8vXiuxusNAERLlBJ3c2DIG8vVdgOIoe50dwPLLpoKmXMqT4qFdHSN5YNCFQIeCWuCvdhItouyld5ToWGP6qne8LdLkxOO2EhJFziTXA4+Lk946cOkV1ytlb3wqLv8PIscAzEzNtoSsFUMTqDOe5Nwkd6vznApD3+QZqnKAy0mcxzr223V81mpIOUrn7e77YWmZ4aTTXcMXouxVeqtsPbQYE1WfYvYz1vIbjbS9LquU+ISmE5Xz4u1nSbAU+3hlTRO1PayuNK2G/QgbqOco1gL/Dta6eYGcqdh7rx38dcmf3SqAjcL5jX6T8RtkEJF1jE5EvC+i9E87Kx3pfD2ibp0Hg4lcUQSe5GQM83W7va2lZyvR53Lp0+6eoUtbquxJ0Y7UsfELFh4QKgIXiIx7h0fflAg4hD+g/ZucqgQgXRH2fmS63w+c67KbfIxb/sz32lND+gXAn6ptoySvOEaEmOxb/oSMvID9h7Enl9DwV17B2DU9Z6z0SCdiRZUkNMHaKfQH8c5POIrNn9N0KGEMeoTrMlT9eKHHUwxYUo7kHO8FZga017HR3phpmrrf34vffJtYS4O6bZtJO1eZTFbgXwPI4aAj0fC/dnA7bvhg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f2a79e-4e48-44e0-ca9a-08dbbdcef6aa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:54:40.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1bSaefXoIilRK9gfVdwu41sd4jHxjW0NIq6uOwlfSYUHa7XZLCer+x5ZCX4WCYmvtjY50WM3BM2MEDDA/TlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_11,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250105
X-Proofpoint-GUID: c8PB6cLlpUmjUyJPkQ7JCAt9ThjNJqfa
X-Proofpoint-ORIG-GUID: c8PB6cLlpUmjUyJPkQ7JCAt9ThjNJqfa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 24, 2023 at 03:52:28PM +0200, Lorenzo Bianconi wrote:
> Introduce write_threads, write_maxblksize and write_maxconn netlink
> commands similar to the ones available through the procfs.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - remove write_v4_end_grace command
> - add write_maxblksize and write_maxconn netlink commands
> 
> This patch can be tested with user-space tool reported below:
> https://github.com/LorenzoBianconi/nfsd-netlink.git
> ---
>  Documentation/netlink/specs/nfsd.yaml |  63 ++++++++++++
>  fs/nfsd/netlink.c                     |  51 ++++++++++
>  fs/nfsd/netlink.h                     |   9 ++
>  fs/nfsd/nfsctl.c                      | 139 ++++++++++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  15 +++
>  5 files changed, 277 insertions(+)

This looks pretty close to me. A couple of comments below.


> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index 403d3e3a04f3..10214fcec8a5 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -62,6 +62,18 @@ attribute-sets:
>          name: compound-ops
>          type: u32
>          multi-attr: true
> +  -
> +    name: server-attr

Or, say, "control-plane" ? "server-attr" doesn't seem very self-
explanatory or specific.


> +    attributes:
> +      -
> +        name: threads
> +        type: u32
> +      -
> +        name: max-blksize
> +        type: u32
> +      -
> +        name: max-conn
> +        type: u32
>  
>  operations:
>    list:
> @@ -72,3 +84,54 @@ operations:
>        dump:
>          pre: nfsd-nl-rpc-status-get-start
>          post: nfsd-nl-rpc-status-get-done
> +    -
> +      name: threads-set
> +      doc: set the number of running threads
> +      attribute-set: server-attr
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - threads
> +    -
> +      name: threads-get
> +      doc: dump the number of running threads
> +      attribute-set: server-attr
> +      dump:
> +        reply:
> +          attributes:
> +            - threads
> +    -
> +      name: max-blksize-set
> +      doc: set the nfs block size
> +      attribute-set: server-attr
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - max-blksize
> +    -
> +      name: max-blksize-get
> +      doc: dump the nfs block size
> +      attribute-set: server-attr
> +      dump:
> +        reply:
> +          attributes:
> +            - max-blksize
> +    -
> +      name: max-conn-set
> +      doc: set the max number of connections
> +      attribute-set: server-attr
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - max-conn
> +    -
> +      name: max-conn-get
> +      doc: dump the max number of connections
> +      attribute-set: server-attr
> +      dump:
> +        reply:
> +          attributes:
> +            - max-conn
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 0e1d635ec5f9..f3dde1b1e162 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,6 +10,21 @@
>  
>  #include <uapi/linux/nfsd_netlink.h>
>  
> +/* NFSD_CMD_THREADS_SET - do */
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_ATTR_THREADS + 1] = {
> +	[NFSD_A_SERVER_ATTR_THREADS] = { .type = NLA_U32, },
> +};
> +
> +/* NFSD_CMD_MAX_BLKSIZE_SET - do */
> +static const struct nla_policy nfsd_max_blksize_set_nl_policy[NFSD_A_SERVER_ATTR_MAX_BLKSIZE + 1] = {
> +	[NFSD_A_SERVER_ATTR_MAX_BLKSIZE] = { .type = NLA_U32, },
> +};
> +
> +/* NFSD_CMD_MAX_CONN_SET - do */
> +static const struct nla_policy nfsd_max_conn_set_nl_policy[NFSD_A_SERVER_ATTR_MAX_CONN + 1] = {
> +	[NFSD_A_SERVER_ATTR_MAX_CONN] = { .type = NLA_U32, },
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] = {
>  	{
> @@ -19,6 +34,42 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.done	= nfsd_nl_rpc_status_get_done,
>  		.flags	= GENL_CMD_CAP_DUMP,
>  	},
> +	{
> +		.cmd		= NFSD_CMD_THREADS_SET,
> +		.doit		= nfsd_nl_threads_set_doit,
> +		.policy		= nfsd_threads_set_nl_policy,
> +		.maxattr	= NFSD_A_SERVER_ATTR_THREADS,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	= NFSD_CMD_THREADS_GET,
> +		.dumpit	= nfsd_nl_threads_get_dumpit,
> +		.flags	= GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		= NFSD_CMD_MAX_BLKSIZE_SET,
> +		.doit		= nfsd_nl_max_blksize_set_doit,
> +		.policy		= nfsd_max_blksize_set_nl_policy,
> +		.maxattr	= NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	= NFSD_CMD_MAX_BLKSIZE_GET,
> +		.dumpit	= nfsd_nl_max_blksize_get_dumpit,
> +		.flags	= GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		= NFSD_CMD_MAX_CONN_SET,
> +		.doit		= nfsd_nl_max_conn_set_doit,
> +		.policy		= nfsd_max_conn_set_nl_policy,
> +		.maxattr	= NFSD_A_SERVER_ATTR_MAX_CONN,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	= NFSD_CMD_MAX_CONN_GET,
> +		.dumpit	= nfsd_nl_max_conn_get_dumpit,
> +		.flags	= GENL_CMD_CAP_DUMP,
> +	},
>  };
>  
>  struct genl_family nfsd_nl_family __ro_after_init = {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index d83dd6bdee92..41b95651c638 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -16,6 +16,15 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
>  
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb,
> +			       struct netlink_callback *cb);
> +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> +				   struct netlink_callback *cb);
> +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> +				struct netlink_callback *cb);
>  
>  extern struct genl_family nfsd_nl_family;
>  
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index b71744e355a8..0167b7fd0d63 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1694,6 +1694,145 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
>  	return 0;
>  }
>  
> +/**
> + * nfsd_nl_threads_set_doit - set the number of running threads
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	u16 nthreads;
> +	int ret;
> +
> +	if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
> +		return -EINVAL;
> +
> +	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);

I worry about what happens if someone sends down a value larger than
64K. While not a likely scenario, the behavior is not well defined,
and I don't think the implicit type conversions are necessary.

Can nthreads be u32?


> +	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> +	return ret == nthreads ? 0 : ret;
> +}
> +
> +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
> +			    int cmd, int attr, u32 val)
> +{
> +	void *hdr;
> +
> +	if (cb->args[0]) /* already consumed */
> +		return 0;
> +
> +	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> +			  &nfsd_nl_family, NLM_F_MULTI, cmd);
> +	if (!hdr)
> +		return -ENOBUFS;
> +
> +	if (nla_put_u32(skb, attr, val))
> +		return -ENOBUFS;
> +
> +	genlmsg_end(skb, hdr);
> +	cb->args[0] = 1;
> +
> +	return skb->len;
> +}
> +
> +/**
> + * nfsd_nl_threads_get_dumpit - dump the number of running threads
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
> +				NFSD_A_SERVER_ATTR_THREADS,
> +				nfsd_nrthreads(sock_net(skb->sk)));
> +}
> +
> +/**
> + * nfsd_nl_max_blksize_set_doit - set the nfs block size
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> +	int ret = 0;
> +
> +	if (!info->attrs[NFSD_A_SERVER_ATTR_MAX_BLKSIZE])
> +		return -EINVAL;
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (nn->nfsd_serv) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	nfsd_max_blksize = nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_MAX_BLKSIZE]);
> +	nfsd_max_blksize = max_t(int, nfsd_max_blksize, 1024);
> +	nfsd_max_blksize = min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE);
> +	nfsd_max_blksize &= ~1023;
> +out:
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> +				   struct netlink_callback *cb)
> +{
> +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
> +				NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
> +				nfsd_max_blksize);
> +}
> +
> +/**
> + * nfsd_nl_max_conn_set_doit - set the max number of connections
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> +
> +	if (!info->attrs[NFSD_A_SERVER_ATTR_MAX_CONN])
> +		return -EINVAL;
> +
> +	nn->max_connections = nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_MAX_CONN]);
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> +				struct netlink_callback *cb)
> +{
> +	struct nfsd_net *nn = net_generic(sock_net(cb->skb->sk), nfsd_net_id);
> +
> +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
> +				NFSD_A_SERVER_ATTR_MAX_CONN,
> +				nn->max_connections);
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
> index c8ae72466ee6..59d0aa22ba94 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -29,8 +29,23 @@ enum {
>  	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
>  };
>  
> +enum {
> +	NFSD_A_SERVER_ATTR_THREADS = 1,
> +	NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
> +	NFSD_A_SERVER_ATTR_MAX_CONN,
> +
> +	__NFSD_A_SERVER_ATTR_MAX,
> +	NFSD_A_SERVER_ATTR_MAX = (__NFSD_A_SERVER_ATTR_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET = 1,
> +	NFSD_CMD_THREADS_SET,
> +	NFSD_CMD_THREADS_GET,
> +	NFSD_CMD_MAX_BLKSIZE_SET,
> +	NFSD_CMD_MAX_BLKSIZE_GET,
> +	NFSD_CMD_MAX_CONN_SET,
> +	NFSD_CMD_MAX_CONN_GET,
>  
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> -- 
> 2.41.0
> 

-- 
Chuck Lever
