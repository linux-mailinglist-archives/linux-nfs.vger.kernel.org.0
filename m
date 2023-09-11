Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0808979C12E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjILAnT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 20:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjILAnR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 20:43:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB0483B8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 17:31:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJgWTN021332;
        Mon, 11 Sep 2023 22:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=WIVPC2TJA2x5qh1OOLYxHF/XbX+2Iqk0i/Rmkxd28bg=;
 b=cqPJc1+cQQGaeF2xVwb0eDXU+LDF8nhN6lqUPRLbdJUw5WpHC5pwa70hnSf6narcuTy/
 8330sJFFI7KI79WiuxWDpb9C4r1FgyqGz5IPUhV+ijhsO2sbTI7I4E2ynsi6Uh/EjoIx
 c6OSopv2cSCaYMtU6ibcdXg3NppjBtJ2IV119r45wCbupoz8dEG17Ub2gwZt5gtEtqTm
 fhVPJdMw5OUUJRGnE5B44rDdNlsq3753upuKwrKjrIK44Rl3E+qklBbzlTXtEZq3pNIw
 e3IUvMXOHIlY2+mxggVIcJNPsC6ZEHYAN9sZPbDfbQg2O6jYb4QlSISEP9W1yAjGxsag 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwqtkmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:26:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BKhLW9033088;
        Mon, 11 Sep 2023 22:26:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wke4rc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmBpvr0UkAMOvpMaIzfUNHj2DNonXqkqF4065sXhsMCEaCMUE+SF4BIyt4myKS6ozil83yOoyOOXyVcRJzkAdWs6Bp4U/q6VCmFOhuAxRVimYOngtJxPwfYbZrNZCZY7gZK0tuBPIinih6aszZxstrWfo05egdRRxohtmnQi0PUwI0FDIRzSj2BCe0dW3/q8kIymBKr7qWuKvRHMf9FuzO9go73HGrUo3MsDTivde4MqYbcvoBldXBMNIO3Gq3eShjahZxine+3UXWelpz+YSx0vyFdHgEbClOZ7W2i2u75C3Tz3Xt4Lj/Vo+C0PeBxmolqDB+9jpbqCeT/pOZy8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIVPC2TJA2x5qh1OOLYxHF/XbX+2Iqk0i/Rmkxd28bg=;
 b=UtjMMsULQczy6Q8vpqxpZSIZOWZBOhql9wTVkQSvpYqVz+PBnT/A4het6xD0ihTGVv5/oMCTsVqcGzscb72/ekc7NJFzXLosNRaDlaNqvBRnWbZzz9v+VIVAalXqnCOczgt0OXgGc5McCVslgF3mx6rPatx7cDZR1GwqYfBuj8LG9j/Xi9PGaSWheC48IvZ61FW7crdGBQS6vHbErpVfUomPWqT+B593ZydAmWGCNzTU7OneGNr1k8ccOi6C3o+YsJ78ooY2fyDOIQq8ONZqAw69sRE6TcQ0dVVLKQ8lo4bozywvfjRrrDK1cmuiehVUBX8lKIhXrcrwo1YLvJjOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIVPC2TJA2x5qh1OOLYxHF/XbX+2Iqk0i/Rmkxd28bg=;
 b=JQiScbpeeQZuhPOL0i3zwTkZgFZeazolRcGSfH8KXNGY4J1I057CPxh86SkCUCEFHeMOtPPvZkMS84X43A2r7aMoqMUiWSwztp3+9Lqt2NHmbwhEh91703EAgzd+shvJ9/MyxB3bAFvgMx3yPNM63bL/AN+FJX7+pAcAXx+iksA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5343.namprd10.prod.outlook.com (2603:10b6:5:3b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:26:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:26:50 +0000
Date:   Mon, 11 Sep 2023 18:26:47 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Handle EOPENSTALE correctly in the filecache
Message-ID: <ZP+UJ44uKwcM2u8O@tissot.1015granger.net>
References: <20230911183027.11372-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911183027.11372-1-trond.myklebust@hammerspace.com>
X-ClientProxiedBy: CH0PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:610:32::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d6ffb9-3a40-406a-14bd-08dbb31631a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqaTiE0RJ7wAOFcLwkF7X9ISTdwbbnxNy+RHpcgeDu//Jp1TMCPy4mgysnk9buj9uwvej/nM+Nd6m6G028Bdm0BDbtJ0k6JLqOhhbJbxGoCo2RC7/gXSecIasOTc0IXgWpLnRjdruODgj+2cXhSh6/GelijQzlZRgUkKqg911SYeRA8KOiR8M3XmfgrpQ3PYDMC7Z47xYzz7HOj2BIvI3StNaby/Xo86hL9yGSgcTwMdiLjmqSFHkWagbKyFwKVk2LEu4J7Cn6oDnZmqZzK4r2H95lWvvxVgy7IC1W1KMU8XMRgNjDNIdj2WBSD0P9NrN/nRrI7WSen1sKkO/xm7d1UfYrYkAlkRw3987eYFMHtL/j7vPnXwdVi7hbxpY1hvMM6fqf83mrBA5w/tUwOdXstYXVObyrNXGhoUMsC42SSggSd2bWL9MPd9KdCW8anLDqhg3si5y6JDhNBoD8MARaR5EO4xzd401zbcmXlrXaIxPOHntwz2VyZNOuGOdRYcG7JqL9hkOT212G0tthiXksPDOKg5AvwczMYnDbgY0u/mvn6pn+/Puh7SsLgG1q8TCmYNpLypZ8dLQih9KR9dfjb1VtO35b86GAyf3rqw56A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(1800799009)(451199024)(186009)(6666004)(6506007)(6486002)(9686003)(6512007)(478600001)(83380400001)(26005)(6916009)(66946007)(44832011)(66476007)(66556008)(5660300002)(4326008)(316002)(41300700001)(8676002)(2906002)(8936002)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBlUxsL4qVwatLEZlv6o1bIC0BOWV2F+6Rmy83VquYKbxoUfmhld7s4wg7so?=
 =?us-ascii?Q?R17fr9v8KV9kB2Zlla2cy67sW82FInk0TKMZEqAMAX8PE9vi6SsScyxi2TMd?=
 =?us-ascii?Q?ZAnHC18RXXEpS5bJT7bwDtRGK+7RWls4yZr5T2vICQDsbKflMe3EFIiZ16uX?=
 =?us-ascii?Q?8iOXYtkDK1/3KpNeOBYv8SQWGRlq7cgln4n7/rAZrQdTzAbREVSpiB+mFHNU?=
 =?us-ascii?Q?rD7q5AIZh9Rlk0Y3kYPAo4l8jlaieIM8jQRv89ggVvnIlvTWrbhCvwFlpz/x?=
 =?us-ascii?Q?TpcYtJhEWLvO0GfcFh+Pbscnq4iIY9S5J2E8BoE6t+pB8a1NsoK9wzfdVb/3?=
 =?us-ascii?Q?r+x4SZi5H3h0WR/LWXrgCssXndfnI/1zMRcKqiQzwr6hPkaaWkkKmTav/+w5?=
 =?us-ascii?Q?2PjpZUIwVWloa8GUndIpkDFPZbQMYh7kzR5CKr414qrSujRRPhBadgYmoVcz?=
 =?us-ascii?Q?Pfv1rk2EsQcJ5U2dkZYy0t26z8wib6QnIwPzjMd8HWRjXx5MceyZAwIjA40u?=
 =?us-ascii?Q?bF+SEajzg7NNyyqPY3pRpMX2pDXFK7QaDMRjkItmZmheLehM5Mb8nRHhId7T?=
 =?us-ascii?Q?e8BG8qoBxYJuWRZp3p6IQhY/Dp32Ky7w4RZv16FSVycj4J1kUxCrqqYWuOfg?=
 =?us-ascii?Q?uHqptaX+x3H8TDnxvGx5qj5PbEzVgBKQFiEdD5bmv1dEKT4zOT515U2tL9Zf?=
 =?us-ascii?Q?0WRtBytMyQG2fgk25KVCVReLSF2pxmLYAh34xfE53jdrAb+8Iml7Zcr5lhGe?=
 =?us-ascii?Q?xZns2N5p1Yod/5PG4L+IUwddvmPF9VtKPvGk1y9tF+Y1qSTZcBecHcmpoA5E?=
 =?us-ascii?Q?eehHpWEWgEmebV3hH1dLSPrqRWKMRaF/KRo7r2vvrlI5s5f4fs3jBccFY7so?=
 =?us-ascii?Q?f1bgp/vHawZyCjmXJm4dPCj0wBH1AzIt1PFSbVgX8FxmNmq9U8pIAroKY3qM?=
 =?us-ascii?Q?q/h4+JHzTuVKlgkF5LBf483XsQdHDhDD0cgAgbvA3O6uGwoIwL5baMa04gEo?=
 =?us-ascii?Q?Lo4IuspnFYI0icInxOhNvFUt0pwOqG47noMV5rJf79qugq2hg/OPz9rl19/r?=
 =?us-ascii?Q?OFU3LrlA3Ufr2CnP6CXennFlAA3txFhCdTCUMHQJgZn+7kzf2yde6lrmB3yw?=
 =?us-ascii?Q?eII6HIMz0Nue6b3qK0J0lXZzUiyl3DqvL0VbVIJ+Nzhddc97pyOHvuBOTud8?=
 =?us-ascii?Q?B/fh2x2iGYevFnJuVVF8niFPhzY1uvmpjYOKMRxmpTI52hex+2sCDl8KIZzo?=
 =?us-ascii?Q?BqH5Cp6MiIVXuQ3281jL3DfFsFQV5V0Vd2YHT/zcaSCeqTn14tgI5WTW/fSA?=
 =?us-ascii?Q?HFjw1vyrSPRQykXGTJYblPhTsZtfg9ISvkdRQtR28t0kvMLV8INn5/PAgEjM?=
 =?us-ascii?Q?qrH5WE12WYTChduiC2IM4uk8bcNoG9EeUMoLfIk//OKteOLCc7shS8ZVZ3V+?=
 =?us-ascii?Q?14hUb0/plAoE7dU7z2lB1+UpXKkyC9PmUtT15XUlAgli+e5jouCo+e3rDDRQ?=
 =?us-ascii?Q?abAbOTZttyfq5pndMzyglsUlD8t1Emg7N5HjhmRiq7HOsRZPc0h6DXsN9L4c?=
 =?us-ascii?Q?pCEJuwGfFljKV8tg3001sFx//ySotopXou/FoLGVGSS7pZgr+6mIrvFLjVWu?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pr4KK8n1Ff5m2Kj9pQMYqcc1XGvwK2r+j00iWCJ7qTlyFZAaNtDs1FP3eo1/xBFYU8sdl8Y7qh+Arwqldk3yWzkFWv6MitF8AnXpbsWiHO9ANuZ6z45kKJDl0A9s+qDJ0lPx/yYVefgHPEs7CAQI4orpbKtlu3buzs/hxpM3GHnkDU7Vu3gKezuNTq+qcHb5AO1KY66bSTYvcmzIBz/BGYW88TsLv+Y7Pmy/6LceQ291+wkK0diNhXboD5vUn1qLuljiEVMEXN7VlOSfm/xRe1FVH88s+x7iWbDc2FM7kDwgB2ovkY9ArI3VWOvguboIiy6RLdZ6O2dCkiiKVxkCzEmXU0/z200ObFnAhLUynHD9yGqudbM6nAiT2U6ga8ej+6x0vngRfP17Skv/VXJ7RBJILoxnPfqlZAl+6OzzEacCAqRt5iaYSKapC3Bhtn0OORgi+HH+3LrmW9RGHpRo0NUo3EaN9OQsfH1z0gMvlUq5CNZoxd1uVbuwXgac4x8aHJbGhvijZEaqExnfGFtKgL3L9S+S9pvtm/aHvF5ZY7jnApHAnc2EMlk2ZfmbIcldICoL7Cs7FuCgdpLfFgq1Kihp+hesdHA31wffMnik+qxLabhyW8bdq6DlSyGIgJET9JLjSjsSCq+XO3f+oePtwke1t4Yl25H3kz4ItxqpVZ/DjFDb7Ph77aZEM9V8nCbvMawLBlVSq3Ct7mXT8t+8JOxE+9qWMp767gHcjxJVrO7pjpbGQcpTEYgCzzS+MTp1DmT0O5uLpS8NhzlahF0721m3oxsNHDWHnaUE2f0cU8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d6ffb9-3a40-406a-14bd-08dbb31631a5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:26:50.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0paaNnI68VdfYqFMyddf+ZXxeTtyqz8OBS3BkrKQFzGZKzqIjtxLOnMNjD2tx2DA48emRmBdJFheR7sUuNx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=845 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110206
X-Proofpoint-ORIG-GUID: 13Z1xHq1tkDbN9aTHzb57dKvzE4vihJn
X-Proofpoint-GUID: 13Z1xHq1tkDbN9aTHzb57dKvzE4vihJn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 11, 2023 at 02:30:27PM -0400, trondmy@gmail.com wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The nfsd_open code handles EOPENSTALE correctly, by retrying the call to
> fh_verify() and __nfsd_open(). However the filecache just drops the
> error on the floor, and immediately returns nfserr_stale to the caller.
> 
> This patch ensures that we propagate the EOPENSTALE code back to
> nfsd_file_do_acquire, and that we handle it correctly.
> 
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/filecache.c | 27 +++++++++++++++++++--------
>  fs/nfsd/vfs.c       | 28 +++++++++++++---------------
>  fs/nfsd/vfs.h       |  2 +-
>  3 files changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ee9c923192e0..07bf219f9ae4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -989,22 +989,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
>  	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_file *new, *nf;
> -	const struct cred *cred;
> +	bool stale_retry = true;
>  	bool open_retry = true;
>  	struct inode *inode;
>  	__be32 status;
>  	int ret;
>  
> +retry:
>  	status = fh_verify(rqstp, fhp, S_IFREG,
>  				may_flags|NFSD_MAY_OWNER_OVERRIDE);
>  	if (status != nfs_ok)
>  		return status;
>  	inode = d_inode(fhp->fh_dentry);
> -	cred = get_current_cred();

If memory serves, we have to hold a reference to the current cred
through the acquire process. Otherwise, the cred can be released
while nfsd_file_do_acquire() is still running, which results in an
oops.

What's the reason to replace get_current_cred() with current_cred()?


> -retry:
>  	rcu_read_lock();
> -	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> +	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
>  	rcu_read_unlock();
>  
>  	if (nf) {
> @@ -1026,7 +1025,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	rcu_read_lock();
>  	spin_lock(&inode->i_lock);
> -	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> +	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
>  	if (unlikely(nf)) {
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
> @@ -1058,6 +1057,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			goto construction_err;
>  		}
>  		open_retry = false;
> +		fh_put(fhp);
>  		goto retry;
>  	}
>  	this_cpu_inc(nfsd_file_cache_hits);
> @@ -1074,7 +1074,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		nfsd_file_check_write_error(nf);
>  		*pnf = nf;
>  	}
> -	put_cred(cred);
>  	trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
>  	return status;
>  
> @@ -1088,8 +1087,20 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			status = nfs_ok;
>  			trace_nfsd_file_opened(nf, status);
>  		} else {
> -			status = nfsd_open_verified(rqstp, fhp, may_flags,
> -						    &nf->nf_file);
> +			ret = nfsd_open_verified(rqstp, fhp, may_flags,
> +						 &nf->nf_file);
> +			if (ret == -EOPENSTALE && stale_retry) {
> +				stale_retry = false;
> +				nfsd_file_unhash(nf);
> +				clear_and_wake_up_bit(NFSD_FILE_PENDING,
> +						      &nf->nf_flags);
> +				if (refcount_dec_and_test(&nf->nf_ref))
> +					nfsd_file_free(nf);
> +				nf = NULL;
> +				fh_put(fhp);
> +				goto retry;
> +			}
> +			status = nfserrno(ret);
>  			trace_nfsd_file_open(nf, status);
>  		}
>  	} else
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2c9074ab2315..98fa4fd0556d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -823,7 +823,7 @@ int nfsd_open_break_lease(struct inode *inode, int access)
>   * and additional flags.
>   * N.B. After this call fhp needs an fh_put
>   */
> -static __be32
> +static int
>  __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  			int may_flags, struct file **filp)
>  {
> @@ -831,14 +831,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  	struct inode	*inode;
>  	struct file	*file;
>  	int		flags = O_RDONLY|O_LARGEFILE;
> -	__be32		err;
> -	int		host_err = 0;
> +	int		host_err = -EPERM;
>  
>  	path.mnt = fhp->fh_export->ex_path.mnt;
>  	path.dentry = fhp->fh_dentry;
>  	inode = d_inode(path.dentry);
>  
> -	err = nfserr_perm;
>  	if (IS_APPEND(inode) && (may_flags & NFSD_MAY_WRITE))
>  		goto out;
>  
> @@ -847,7 +845,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  
>  	host_err = nfsd_open_break_lease(inode, may_flags);
>  	if (host_err) /* NOMEM or WOULDBLOCK */
> -		goto out_nfserr;
> +		goto out;
>  
>  	if (may_flags & NFSD_MAY_WRITE) {
>  		if (may_flags & NFSD_MAY_READ)
> @@ -859,13 +857,13 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  	file = dentry_open(&path, flags, current_cred());
>  	if (IS_ERR(file)) {
>  		host_err = PTR_ERR(file);
> -		goto out_nfserr;
> +		goto out;
>  	}
>  
>  	host_err = ima_file_check(file, may_flags);
>  	if (host_err) {
>  		fput(file);
> -		goto out_nfserr;
> +		goto out;
>  	}
>  
>  	if (may_flags & NFSD_MAY_64BIT_COOKIE)
> @@ -874,10 +872,8 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		file->f_mode |= FMODE_32BITHASH;
>  
>  	*filp = file;
> -out_nfserr:
> -	err = nfserrno(host_err);
>  out:
> -	return err;
> +	return host_err;
>  }
>  
>  __be32
> @@ -885,6 +881,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		int may_flags, struct file **filp)
>  {
>  	__be32 err;
> +	int host_err;
>  	bool retried = false;
>  
>  	validate_process_creds();
> @@ -904,12 +901,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  retry:
>  	err = fh_verify(rqstp, fhp, type, may_flags);
>  	if (!err) {
> -		err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
> -		if (err == nfserr_stale && !retried) {
> +		host_err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
> +		if (host_err == -EOPENSTALE && !retried) {
>  			retried = true;
>  			fh_put(fhp);
>  			goto retry;
>  		}
> +		err = nfserrno(host_err);
>  	}
>  	validate_process_creds();
>  	return err;
> @@ -922,13 +920,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>   * @may_flags: internal permission flags
>   * @filp: OUT: open "struct file *"
>   *
> - * Returns an nfsstat value in network byte order.
> + * Returns a posix error.
>   */
> -__be32
> +int
>  nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
>  		   struct file **filp)
>  {
> -	__be32 err;
> +	int err;
>  
>  	validate_process_creds();
>  	err = __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index a6890ea7b765..e4b7207ef2e0 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -104,7 +104,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  int 		nfsd_open_break_lease(struct inode *, int);
>  __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
>  				int, struct file **);
> -__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
> +int		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
>  				int, struct file **);
>  __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct file *file, loff_t offset,
> -- 
> 2.41.0
> 

-- 
Chuck Lever
