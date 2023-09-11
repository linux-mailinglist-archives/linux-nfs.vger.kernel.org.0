Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45A79B893
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbjIKV7P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbjIKSKX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 14:10:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDF103;
        Mon, 11 Sep 2023 11:10:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BChRRv011015;
        Mon, 11 Sep 2023 18:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4BaySpWe1DF/mGlI50WPnvq7HNMidAvvq9rFEjaWAnU=;
 b=aWen1D6c8J0lMmJ5FM9vQFNsVMEv42Yyx0QjTSfIi9jkIVB0t6SqpEQ5TReXrUOSeUu+
 jrrkxxWb5vdJSHKybchwflw0KDvBHvwaBqAFsulTNW64IpD9lQ/Hdtokn0rQSbRqcQ+d
 6aq4ADhTFsuOJHQgsaarXSRKcBz2jJs8WqHXaJ67sLFWPsgjVxAzBhf475/8xcuE/+N5
 e8tKPskf6sBr/zrRi6eoyr7+NIMuGyC6HQpRbm8C18d6xfnW8hHOS29Z3pm540ZgYYEc
 s7zFXmY6M+XWQtUn3ldBDxp4BbZimz9ngUPEFm3/oXBEIlJXpdlqTFszYSdQaPaktcjs Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1ju1t4be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 18:10:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BHNlpa002861;
        Mon, 11 Sep 2023 18:10:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5augnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 18:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoUaOZkSrphsauXVigvaxbClzScZ+Cc/xebhtp500etlqW7T+IW9IKTpDi9dotf9xMjBwP6vG6S8MBiDzXpROQjldB8USBfLCmagVOZ7qY79SmlCjDEL05spEPFdJVHbReiBuvYBDtqTcV62fi2AhEgAAO68rl22N6IEzhFdvlOndogrY+7OLasVzKFzFdumvgf5mCKssoKVrEn8trFYGyNAvz3L5n2PbzXzh8e2h0rc9iEYmpDsb/mNv+aKpVee096x0K7iRfZUdIivtSnBjFk2ZiGpCNcTTO89NwSmEMF8XlxS4hnKgdZfI6UyVXg1Scb8BCnj21GJyLWbqsHLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BaySpWe1DF/mGlI50WPnvq7HNMidAvvq9rFEjaWAnU=;
 b=Tw8fw2tX1AdToBtsjquv7acEvb6ueFdQfByl2xgQ0vVfod+rRiE6WqaQIIedrFw4VFcl3Rs3ejiUZ4Ckhm0Rkv3vqQS8zMDT60TnVxZzd5gj6fhJBBJKWZ1/BN+pvIope1XSZcQFHzU9ummCjQdL4nhMZkIyjbUIgId85PQLcNGU/py77byAFpUblDr47Nmg8/sMc8flaKGzWVEXohxPpkD4slnYhQFtIRh4XhlYYoy3vLu8aEtlkeMTTa+LiGclgwHQUM0jc5t3GFoTF6OgOqfhxg2l4yEoL5xsBe233/bzE+XNhdymRtD6czFOMOZUwzh1fGJcHe87ErgzBC7jog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BaySpWe1DF/mGlI50WPnvq7HNMidAvvq9rFEjaWAnU=;
 b=dlmZEx9fNhPqI/lyW/+7xroX92uscxZ0I/JvnzGpo8W5Bckjbw+fD14Bjg9IwAJrXkvYewsTVwHnmJzlQx1WI79c3QFqxrkCznt2zI/GV1qz7JrFF7A0Qb4QgIzXs0tS72h2U6fw8Ie1B5TBBMw0aF6LyYP+fMpr8U6MV71yzB0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5650.namprd10.prod.outlook.com (2603:10b6:303:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 18:10:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 18:10:08 +0000
Date:   Mon, 11 Sep 2023 14:10:05 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Message-ID: <ZP9X/f43T4FwhoPH@tissot.1015granger.net>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH2PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:610:38::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: c576c941-bb3a-4cf8-ee0e-08dbb2f2550f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Riv178B6l9fGdm9T2PW2J4gUaiKCvXjUmAO19wnb5dCUw1ahRcJNePymYSGfwvUbvYvCgPdeZxlIgMIzYWkA4KL73rs1bpXfiDeurEd4r3PC7RYjUvPjROK0kGyCoCgUDglh58meqn0UF5DgUnFpE2/T2Q6UZEUtugMi4E/PBQO9cmrN9DCTzUljFoXdkV0Qays6+bchIC9rZuubR4Oqh5wKK7zHUkK3OCp9arnaTqRyIrhmbVNe3LoupwUaGLOBn9CnavJ/mIzFcGox/GVL6WmQqi2hn0WEveuwOaHoyv9XD5zPj75xdjYr+VGn3TU6NE0aJvVIV7pBOjlEa9QhNJELY+C2p79pqvpDNeQpSno9IgijsSs7cD9PqAVGxNNkY518SgF9TX2LN5xRDSi5hy/d/EMFcQQNFfWMV6KwlLHmxYBpivv70sL2kxM1bS10QypsKjzoHWSiW2nXyO06wf40V2QyYWu4pfYy1zoEs2ePZj0gOiH1oaY4YXeCZ6PZJ/VAfmGhT166SjY4cbGomkLa68MZZPQ0cpyP4l3cS9Mp+LyCfJ6Z649Po/kVk5v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(186009)(451199024)(1800799009)(6486002)(6666004)(6506007)(86362001)(38100700002)(26005)(6512007)(9686003)(83380400001)(478600001)(41300700001)(316002)(8936002)(4326008)(8676002)(5660300002)(2906002)(66476007)(66556008)(44832011)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rG3JvletpU26HEaAGjP7ZWzgcEQBPWoTNYlowkKemZ/G0qB8KAhOLPdSOxeT?=
 =?us-ascii?Q?BdNSgI8xRUSr3ApYrDPQFgmg9tvvhFJARscm3W1G0ZJhShuGpiMf8b+uzaG6?=
 =?us-ascii?Q?qZG8U1aKJWURZsbfKLCtbGcf+LxmVv3dOptzISMOCxtA8ZA8wunCJn63nf/m?=
 =?us-ascii?Q?ecinxrDrl6hMUabGjWMFMI/btaW30ngPKetK2K8PQzacajxjirifMj7aIAR5?=
 =?us-ascii?Q?jbea0WlzwompTZxst/qJergV2bPppQS//sC8nivIjFXJ+Tjvux52aK2OrGGT?=
 =?us-ascii?Q?22xwXLQCEEee3yiBkFjLeYoSR236Z5upcSM/WJCy3MPequiepLWuCjd/S0U9?=
 =?us-ascii?Q?hqb+z1ZQ69UrO0M5jPiUK/VIegaLuhy/Lk6OkqVCc85cWquEGYRCg7qDvwJ9?=
 =?us-ascii?Q?BDLHC8Drv1BUBTBMx7dTAWiUNjt17ithnWREZUeyYnaKdgK8i6kd4GwTOLXO?=
 =?us-ascii?Q?jTtX9lNignM125s15xnONgaPIT6UZYTQBXA4YGAEen9nd4rCmi2kCWBKo+pc?=
 =?us-ascii?Q?Zs9GRwMpkHcLKgvRsWl/O/r4SB/rjiQrQbMQhopmUR/abO5Z/hS6KTQWsbJ0?=
 =?us-ascii?Q?8mPaL4YRBBhpd3VydtmIkDFG9HlU5nl4wMIal9hgmUOj3OkIg+oyWK0J4xlB?=
 =?us-ascii?Q?cTdmE0qC2Ow7rzoDm0WpjYME8bVH6bMztAVzvjb9Y7wmFYdjF3LhhNogLRQo?=
 =?us-ascii?Q?snUU/vuG3IHFuqJDGDMupCd+TRM+NayNUnSyPpPsVxOpmkwyM9sUAa1k7o+E?=
 =?us-ascii?Q?I5f249jcBzoBfrZW77iWF7MVjfOEbNxZlJSxfyfbWPrc8v3NtjOxVh49mmKf?=
 =?us-ascii?Q?ABGRWSr+9vdgHWCAI6cUInlQo91baKkryxZj9CaF8rE2/l9g8ZAn3fipGZ+n?=
 =?us-ascii?Q?KWyGRIMIr4FJ+XS5RKQBQ+S7ekaN3WwwC/o8rfITGeJ4j93A8bVO/LH763C+?=
 =?us-ascii?Q?KmBND55kcRdYLnnPmgKaHgyUcrRo7hGyzNsIMZxrdMjUI3/jWwVT8w9cJgOp?=
 =?us-ascii?Q?OAwZptYC5jhAl2RpJPBeV+jnXBi2Eb6vl3X2TJk49mxwEOZd78I3iScltOg2?=
 =?us-ascii?Q?e7JKlHq4f4kYPuygYw+14hZ/Ihnwbz5eD1Y68sxPS/w4/EJB7YeHTFTj2iYE?=
 =?us-ascii?Q?nmSV5m46wpXmjt+G6UYyHUVoAIiHZeKlSe7FCb1MMnDhNSLnNCJgybQApMFW?=
 =?us-ascii?Q?jrsbVcBeZRF2L3WJ6gCNBHNT3SHFtSnpVnbSD+013j79JXMO2DTl1zGBbnse?=
 =?us-ascii?Q?F8w/Awo7TL/YL7gJY8C7fDOdYnD4qmoRjoE6wDBFuIUMkRjdEcuXTOJXQpAB?=
 =?us-ascii?Q?MEjc09CbK4p6fg/W0kr5E6UoVOFCYqC1jFgz+ZqDl7UUrZHbKHheK16rVCwA?=
 =?us-ascii?Q?Tdg5PeaM4ZxJbJAQEPpxPF2GwNj2Gnk5+boPAu2GUGrMQqj/gYNxC1pmIr46?=
 =?us-ascii?Q?oTbdGyjZztj0FyW+j5YPswJUKzqG9B+QYWvBi6oHjYcndBaQ9pMpeogZKWow?=
 =?us-ascii?Q?CHBYrjD3ULxN59dkBzAOMgEavDuiPEL7fdOyeDjRvZo6VnNFE5ecaAT5qNcU?=
 =?us-ascii?Q?Wj2P0WogTy27GdpiN9QUoX7DrzMir6jVCcf2hhlNlsVgl7fy+R4gJwBitbEF?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VROio1z74W89n1vnq/TKIjQQqyHKahHrA9vnw8Brb0cKUAn8RYUSys9yDgbkgXzgO4Qdq5GCp1MQF29GZrXhRn082ZYEUfKaOgEPBZFczaExnBtwDHn6nDQhPwRnRikkk8PQPA73Ix5CZuOWfdcXFOLS/yPNXssSmhkBd9ody61l5UCgFlce6ud2kh7I8t0oC6Ek7IwTjmpaGzvNJ8TxOexb+RGjfFu7EGjD5efVnIAfLUna1uW0AYdwrUI+NP683anDaQuRkGfgUi4M8qirwpOCL290axp5jOUOUQQLaond88C2IUQ+WlYCgAuG+yTe15K46znI9+UGI9Ioxya1KdwITCL++XK2CC9Wr1SoMSuUWYj7AmgW0raB74hfwJLrO1niucBtyPQtWpYhK7h0qFnSCpH23QXcjunJkH7juI+z+tuK83v6VAGWfBzbQXFVFNOD7oqlS8wIlbmnXMb7LwzxAH2iPey/wlwM1oNTNfWX60Favn/n/bk9fFP3WKktAysdauzq6vmGmiMebDU5A55+O2Koy0GWS/5PvZuSh5vtn/aN9LsI+A56NAvKaMLhQzp6XwVbhE+l2+CfX7tT++/84e1//y2SKUqEYv1SYMVNj7RvctGYMR5hVJnrrFBXhIR4111X5iOjxz7/yBV7mR4Hd3USF6u+rz/h2RvjkJT07+hXTkD4SW5CseSOYhXrpLZBarIkqgnC5dgIoCg9fZa2VgwM+/gpl4sexd34J9ojQyHy69rXBZ8PGewSMh64Ao3hW3APsuoO770Y7IuOhn1jneEvi1Oh6q6VnnK/UBfaZY1Fmtb/XVYYqLCaYclJUW0VnYPBNo5LDFQCXGFmIA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c576c941-bb3a-4cf8-ee0e-08dbb2f2550f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 18:10:08.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEQ8PacHAmbS4Qe5mwqpGdXV2qBQ5h+YPHbtiOjFzja4gQxGKwoBY9JTaNdicaT5zeHySKkbMbXIHK5uefKAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=893 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110166
X-Proofpoint-GUID: KK5waxTf3LzQ9ziNjHZVutjnzHp1b9pF
X-Proofpoint-ORIG-GUID: KK5waxTf3LzQ9ziNjHZVutjnzHp1b9pF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 11, 2023 at 02:49:44PM +0200, Lorenzo Bianconi wrote:
> Introduce nfsd_server.yaml specs to generate uAPI and netlink
> code for nfsd server.
> Add rpc-status specs to define message reported by the nfsd server
> dumping the pending RPC requests.
> 
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd_server.yaml | 97 ++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/netlink/specs/nfsd_server.yaml

I've had a look... the series is simple and short. Thanks!

My only quibbles right now are cosmetic and naming-related, all
of which can be addressed when I apply these. So I'm going to
wait for other review comments to see if we need another version
or whether I can apply v8 with by-hand clean-ups.

Comments below are what I might change when applying this one.
This is not (yet) a request for a new version.


> diff --git a/Documentation/netlink/specs/nfsd_server.yaml b/Documentation/netlink/specs/nfsd_server.yaml
> new file mode 100644
> index 000000000000..e681b493847b
> --- /dev/null
> +++ b/Documentation/netlink/specs/nfsd_server.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +
> +name: nfsd_server

IMHO "nfsd_server" is redundant. "nfsd" should work.


> +
> +doc:
> +  nfsd server configuration over generic netlink.
> +
> +attribute-sets:
> +  -
> +    name: rpc-status-comp-op-attr
> +    enum-name: nfsd-rpc-status-comp-attr
> +    name-prefix: nfsd-attr-rpc-status-comp-
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0

I don't recall whether a zero-value definition is explicitly
necessary. Maybe "value-start: 1" would work rather than
these three lines? Why is zero a special attribute value?


> +      -
> +        name: op
> +        type: u32
> +  -
> +    name: rpc-status-attr
> +    enum-name: nfsd-rpc-status-attr
> +    name-prefix: nfsd-attr-rpc-status-

Specifying all three of these name settings seems a bit
cluttered.


> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: xid
> +        type: u32
> +        byte-order: big-endian
> +      -
> +        name: flags
> +        type: u32
> +      -
> +        name: prog
> +        type: u32
> +      -
> +        name: version
> +        type: u8
> +      -
> +        name: proc
> +        type: u32
> +      -
> +        name: service_time
> +        type: s64
> +      -
> +        name: pad
> +        type: pad
> +      -
> +        name: saddr4
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: daddr4
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: saddr6
> +        type: binary
> +        display-hint: ipv6
> +      -
> +        name: daddr6
> +        type: binary
> +        display-hint: ipv6
> +      -
> +        name: sport
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: dport
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: compond-op

s/compond-op/compound-op

> +        type: array-nest
> +        nested-attributes: rpc-status-comp-op-attr

So, this is supposed to be a counted array of op numbers? Is there
an existing type that could be used for this instead?


> +
> +operations:
> +  enum-name: nfsd-commands
> +  name-prefix: nfsd-cmd-
> +  list:
> +    -
> +      name: unspec
> +      doc: unused
> +      value: 0
> +    -
> +      name: rpc-status-get
> +      doc: dump pending nfsd rpc
> +      attribute-set: rpc-status-attr
> +      dump:
> +        pre: nfsd-server-nl-rpc-status-get-start
> +        post: nfsd-server-nl-rpc-status-get-done

-- 
Chuck Lever
