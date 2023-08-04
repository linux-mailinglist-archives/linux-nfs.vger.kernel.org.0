Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2583177027F
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjHDOD2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjHDOD0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 10:03:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD075B9
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 07:03:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374CBx7N012760;
        Fri, 4 Aug 2023 14:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QzoGbPE+zgeZwelXt0lAD9S+NJdOWYdB+m8ZPtM92lc=;
 b=tivYIohtWeGPjvJt72sXTBNDiDj73UjtgbMo46LtHQrm2dFNcX81G8e5MMpU+WQOu85o
 z9WDD3v05ugi4tWKpMKf8dZ1BywQqX38lsAmu76ITnpxifpFa0rUFufRWM0tSMQ3GrGT
 2x/2+/nKBLS+AxAbOtkD4HxC+P+ZKm+GHhiBw/4gGAN5E1IJxQ0Cdl6S55o0GsCL/0I1
 AdkRz094DWiYMsrqTGI19YOAzmrUAjcsnJgTxgoP1fzBNhFbh1O8YLyAnVbtETxwOr3j
 JRAkczpbzBeM5NLm9GZTRqXrZlygmfUW1YA83JjQWiGI0H1ii7K0KCYobUGnf1YnayCp Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttdbyaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 14:03:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374DMiwm029564;
        Fri, 4 Aug 2023 14:03:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m293t07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 14:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0M64rraLz/Er7sN+SMF32KwX3bEbyLzUx37U7hCVTS7SNoSxNhv5HHa12P/nZujZvvDuRb9tThAgR35H7FL4qGbqoKzlOv/jZNQaRGA7gkFw9e6cIaxB9e2vxWeuoKcslcMNArzhlHR8fV4fZlAW9B22qlKY4xt0KIZt3OU9otuMlGaEcG/7Zp9Qdq4/RhBdKBLD5INNF1aiGtrTjqpACNpfMKKgvGcT63S292PhqjCpcLjsqyZotfiqZfEqcAvuI72in5ERshSl4BfaOhEirUgC9DA/dc2JOk5xLhkv5gFDDKF2JN7ChTk11krs9zeLjTwVAnpzhdEnfmRWhvlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzoGbPE+zgeZwelXt0lAD9S+NJdOWYdB+m8ZPtM92lc=;
 b=JMo54iCyoKgST/SH99a7wr4qIfvr9QexeuJXLgNHKsH6fvOmuoq391wPv3ma/a7wecIiFZExsLP77QeA5CU8q0mszCcymaM5w3kXPc0GhlFw9Qyb+s4JIVm4YACuW7Z3tToQykdtU0jdCfmo8gs9TwLqdW/KhxMNZB8i/KwdsV8h0f+rDf3Sdm78flxk50Kl8dCrrXqU+lr+gdK8+Lo0ATShHLUycXegW5NccYScRQdCXHz4h2rmcCuxWUekvX0fUYpV8gcwOUjYBeOOAiOqEsbPZAEX/iYVM9NETrt3cbEqBcUk/1EJldlsTCeIVTSOxdnHUpXg9vUt0wne2BWdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzoGbPE+zgeZwelXt0lAD9S+NJdOWYdB+m8ZPtM92lc=;
 b=Pfz+0dqfnVIeqkicYh4Zx7p6dKO5BC0ToWgtwR1u/N4D0wtxOVm3dJtQb8wd1TMTWlBtkYnUWAPZR1iX6lUv3gq/e92sGrSaFEP32Pa+mhIn5cnFGB85hjpY+Dah21No4IdkYf37odhtH84TGoictM3nDFU695YlBkep7hoi+J0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 14:02:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 14:02:59 +0000
Date:   Fri, 4 Aug 2023 10:02:50 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZM0FCrItmyHMDcZy@tissot.1015granger.net>
References: <cover.1690569488.git.lorenzo@kernel.org>
 <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
 <ZMQVX5RlQaWt5wkn@tissot.1015granger.net>
 <ZMyvSxMhvH4elsBR@lore-rh-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMyvSxMhvH4elsBR@lore-rh-laptop>
X-ClientProxiedBy: CH2PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:610:50::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 449c28dc-b77f-47cf-e0a4-08db94f3827b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHU1t9xh5UUeQtB3UDHWAw5zEC4jmMveAnfx7dnMIkMiX67CL1ypxH+scUFXEgTpOyJ9CUJKNDL4e5jA3hh0uTf4szim7Ktt4UPuMn6RpAVWn2ME6Hxdq+5cMcyJZAdKsBuMyDNfrK66oXhOaqmwS1y/kuu5Lk5mNb36HJ47hKLVdAaF/DYMs17rTAhZKbq+NhBq29qVD3Vf7zgAsPti2zG8pXbUDU1nbgYysYFCbxh6+NrPkRUk90mkJetOwTwto+ZCFedIiLMsrqxf9QsmpQInC34796XW+faB6ANGA1Dp5gqB6YLidb0EeyTP8xmrKdVe0+eJLmDVOzyiDGsWw44KK6i6nwVbDWausankQa1uyVmKwjUmsD4ghSqinObD0T+j2ohbPifY8KRJq+/PUmmgQ9CrAndM749QX7ejWGB/QixpOAkTVgWq4h3ngcdGahWk5Aa0KYpRHF/XJoMdUof23oYEAgr9pMiqxcmoysMxXA9JIocHI2MU3C2U7kbgilEDSEJpFBrd5GWyWo2TSaOf1hKQ5OSaW8iwBjDrCHwuXeAomTwD3EPxCVfcpagV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(83380400001)(26005)(6506007)(8676002)(9686003)(316002)(66556008)(2906002)(5660300002)(66946007)(66476007)(6916009)(4326008)(44832011)(41300700001)(8936002)(6486002)(6512007)(6666004)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrB1BAydefJnzypB8defwWohZykMjdmjLFDagTB+vxcj5fH691wrnQ3ccs8E?=
 =?us-ascii?Q?5Z2UYmqQU4SLcJ4v1YVUT4ZPh5hfTb6X50SjiMumj8a2NSrEVRy/4csmfox/?=
 =?us-ascii?Q?upPnbKY9wXvXj8Ok/VUo0aBeYLplV0YzmC0ypccGtmqbZORQ4TLe2rBLRgTW?=
 =?us-ascii?Q?mR5KAF+8Ask5ge1xtJ7ggWjnHJTJBVc8pZk5q+PzMP9ebh3SaGqKE3kQg/g/?=
 =?us-ascii?Q?t5WGwpI88IgzUeL+zMC9ZIlIzeIV8qERfuqugBg6pcXueNgbQC58V5NxCEby?=
 =?us-ascii?Q?DgOhyZBZMjiGFmk+aJ7BYjV5GGtf9aKdqpoTZCLWLLDmbrrysgRkIQE16vYt?=
 =?us-ascii?Q?Hw9qzsCCkyXdLH97H0MB3YX2VxF6rMO4+KyqgOPvbjGP6+jSVdHG2BmXiULy?=
 =?us-ascii?Q?LB6Zz9+9+gRDMwCHadUTsd01NEUETYT2tkLS1GR9mdcv9KaQCi3IVGrCJtjZ?=
 =?us-ascii?Q?afWA0+eSNYyEAIdZWQVFQKEZBGCCojuzjuw/gydZdIFwg8zE60ytt1l2WvEB?=
 =?us-ascii?Q?fzHZIblWe2RX3vmZx5uB0GOaKaeljP6jkzcGHJkkSR6CoWs65KgBEG73G3DY?=
 =?us-ascii?Q?qkBBxyMAGBeH3jgsSOwHUUbIYx9uz6CsGTEvT58g18373XSxDz9axHBwufia?=
 =?us-ascii?Q?knJpuJlI2fG5XOfeU+BNwxgXh/QV1xYexbRTn943ueIt3W1JD4cpCxBSt0Of?=
 =?us-ascii?Q?5gcLQ1So2NS3GJR5zfkDasD22Y153NADrUrTa07H7KSuVuJGc7g7yoorkByE?=
 =?us-ascii?Q?mAlIp+USKLp0cTIsdJ7Gjw8kDe0TRrr2XEvcya3AFEN5MbBYUyjNQCjTNw48?=
 =?us-ascii?Q?2tOE+/bmlQX8slY4NuwU34NG5CdhpH/eJaMUAhc4vWkgsaXN+C5q2+LtWKVm?=
 =?us-ascii?Q?EeG7RAMdlE2QguYeIMZIYu8S74ilPtLwHK/rN77f0Lii5mFV8LJSduRbfBvT?=
 =?us-ascii?Q?Bg0h8cNa/srWnl5P/zlRlBzITCt5nxiwsXNjbfdiENd8Sanr2r62SJKCbP7X?=
 =?us-ascii?Q?etoIEQ6elHg1ivNhDTpQ0YiKGKG4jQMrEN2Z5UiGG3D0MY4p5/yuAB5Q8I5f?=
 =?us-ascii?Q?kXSpdvCRjrFeFYucw1pDRDVFrC79kE3jykaxPjiwZ0D0zxdis8nv2B7cfjuI?=
 =?us-ascii?Q?EyXsn57s/TlnozqBdtB/aMVSzH06PQT27d77VVRMg9ItXNGJLTjoGryNDi+f?=
 =?us-ascii?Q?JJI9ykOWhzsGwuOkj88Djz4j8HUmXZP0f/Ifg5s8Fyo4P/rqQLw2FBYgAETU?=
 =?us-ascii?Q?jQCcskgOvAxL8x8N6xbp8WdxluoD+aMYtelX5hPoEHpdpnF8T7NCoM9EXtFp?=
 =?us-ascii?Q?//JqFHE+t5KOPVUsNfK2AAxGUNDPX5vyX7R48CuHjlLH8v555wYtm4PVy/hb?=
 =?us-ascii?Q?ymIObjfRjvMhnVmCZsUp6osNqGE3+qeT2iFpsjc4mwGdH+At+DHtLsgSV0pm?=
 =?us-ascii?Q?YT/uqv0WOmrfjbjcrtLYxXiPuHKBK+OSv9gdgZY7wC0oC+7u0O2C2s017mHS?=
 =?us-ascii?Q?gAlOcE6COruXMMDtACSc9btM0IK9T1INH/PE3bTHVyf7UcIwNPVe4DCTXphu?=
 =?us-ascii?Q?UuiwFO07omk3Tvkaax1gCuwAwliRAiv6mt9q7GafbAKXwMo7g9YOBU6kCALq?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OEvGhqNZEfXF1edeoid8L8C4khB9XadwygGrYN+ZcK/lFEu/5IZnmweRDT+z21XdsMBIrupoR9Ir9SPudpODgStHhD0dEoDQmZ0gvTyXxfKT5hgQqOgOWnFzqNE+0ZaBWFptTuuVp+qjRCsUgLN/UtK75LJb/wN+Qfc4cb480DKUiM+1S8ElUTslWv0do0nkhTQXozkBxzPgPK1M0cx7PfbbT9Q8aUtOSVsAFzy4cTMMsEttS+S4ltogFwpv88DOvAqvVNypkIOkzC7Z/3v9tMiI2ch+K3RKAMkPlDEoCyOCH6Xzt9qApUIPAPpau1THPn2NKvzRgox2NRxJEA/+aGwFc5v+64+3nJhcaIAc5hCJacmMj6aCamzB3fFFNtkMC1jZWLP2oR1v/+psh4IWLnN3iMD6HRfWXsDmshccF1Y/3dpJYMHQrkEjyYwcz7YR39l5FYFUaSjMl5MXSNKyd1+yy1oQFhBRM9irpN8Cc2rOhGXgWxFphRQL/zonaNjEF2TLkepdMudbB7xvjvfVSTsy+Hy6jO85F1/H+gDI1QjtuXxO18lbnXT2BRFFKnXOrOaWIMKHM8vB1k91bG4v7IkTEfC22EnwDYwfkhCMVklnGlbNcw6cxySonxtLJDct8MOLeyaEiOKfmr8sQ+adxR6Z3svge6mTn3wUTedbbzopyKStjkEibQMVBN+TjzpBUNuJC9Jv5hjlmsC9tGJetp6XWSlQKoX/CQlF7MfSBx1+hMUXXrgOQnjyU0BsfvgX3z7Ol5OH4GjQN1LSCWU6uYkeIRh9p1XA9uuj2qUPDyQRHwHjuNtx5c9eEzkTAcvY7DFgtuDNvz4A7t03WzsPZQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449c28dc-b77f-47cf-e0a4-08db94f3827b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:02:59.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+Yxep5rhoEyL5htw1fgHm75+xURD1F1xbuNxBfiv+CpnlbFrk9hMPtyRbjTBxYHt5R0xFN9xouOk3e0ftr9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040125
X-Proofpoint-GUID: Pqnlrfz4KUu6YzX8vSvY7eftBf_j0ELX
X-Proofpoint-ORIG-GUID: Pqnlrfz4KUu6YzX8vSvY7eftBf_j0ELX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 04, 2023 at 09:56:59AM +0200, Lorenzo Bianconi wrote:
> [...]
> > > +	atomic_inc(&rqstp->rq_status_counter);
> > > +
> > 
> > Does this really have to be an atomic_t ? Seems like nfsd_dispatch
> > is the only function updating it. You might need release semantics
> > here and acquire semantics in nfsd_rpc_status_show(). I'd rather
> > avoid a full-on atomic op in nfsd_dispatch() unless it's absolutely
> > needed.
> 
> ack, I agree. I will work on it.
> 
> > 
> > Also, do you need to bump the rq_status_counter in the other RPC
> > dispatch routines (lockd and nfs callback) too?
> 
> the only consumer at the moment is nfsd, do you think we should add them in
> advance for lockd as well?

Ah... the reporting facility is added to the NFS server, not to
SunRPC. My mistake. I got confused because struct svc_rqst is an RPC
layer object.

So this is kind of a layering violation. The counter is for NFS
procedures, but it's being added to svc_rqst, which is an RPC layer
object. We're trying to fix up the places where NFSD stashes its
state in RPC structures. (I recall that Neil suggested this
arrangement).

But I don't have a better suggestion for where to put the counter.
Leave it where it is for now, and we'll come up with something
down the road ... or we'll decide we want the same watchdog for
all RPC services. ;-)


> > >  	rp = NULL;
> > >  	switch (nfsd_cache_lookup(rqstp, &rp)) {
> > >  	case RC_DOIT:
> > > @@ -1074,6 +1076,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> > >  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
> > >  		goto out_encode_err;
> > >  
> > > +	atomic_inc(&rqstp->rq_status_counter);
> > > +
> > >  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> > >  out_cached_reply:
> > >  	return 1;
> > > @@ -1149,3 +1153,121 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> > >  	mutex_unlock(&nfsd_mutex);
> > >  	return ret;
> > >  }
> > > +
> > > +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > > +{
> > > +	struct inode *inode = file_inode(m->file);
> > > +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> > > +	int i;
> > > +
> > > +	rcu_read_lock();
> > > +
> > > +	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > > +		struct svc_rqst *rqstp;
> > > +
> > > +		list_for_each_entry_rcu(rqstp,
> > > +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > > +				rq_all) {
> > > +			struct nfsd_rpc_status_info {
> > > +				struct sockaddr daddr;
> > > +				struct sockaddr saddr;
> > > +				unsigned long rq_flags;
> > > +				__be32 rq_xid;
> > > +				u32 rq_prog;
> > > +				u32 rq_vers;
> > > +				const char *pc_name;
> > > +				ktime_t rq_stime;
> > > +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND]; /* NFSv4 compund */
> > > +			} rqstp_info;
> > > +			unsigned int status_counter;
> > > +			char buf[RPC_MAX_ADDRBUFLEN];
> > > +			int j, opcnt = 0;
> > > +
> > > +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> > > +				continue;
> > > +
> > > +			status_counter = atomic_read(&rqstp->rq_status_counter);
> > 
> > Neil said:
> > 
> > > I suggest you add add a counter to the rqstp which is incremented from
> > > even to odd after parsing a request - including he v4 parsing needed to
> > > have a sable ->opcnt - and then incremented from odd to even when the
> > > request is complete.
> > > Then this code samples the counter, skips the rqst if the counter is
> > > even, and resamples the counter after collecting the data.  If it has
> > > changed, the drop the record.
> > 
> > I don't see a check if the status counter is even.
> > 
> > Also, as above, I'm not sure atomic_read() is necessary here. Maybe
> > just READ_ONCE() ? Neil, any thoughts?
> 
> 
> I used the RQ_BUSY check instead of checking if the counter is even, but I can
> see the point now. I will fix it.
> 
> > 
> > 
> > > +
> > > +			rqstp_info.rq_xid = rqstp->rq_xid;
> > > +			rqstp_info.rq_flags = rqstp->rq_flags;
> > > +			rqstp_info.rq_prog = rqstp->rq_prog;
> > > +			rqstp_info.rq_vers = rqstp->rq_vers;
> > > +			rqstp_info.pc_name = svc_proc_name(rqstp);
> > > +			rqstp_info.rq_stime = rqstp->rq_stime;
> > > +			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> > > +			       sizeof(struct sockaddr));
> > > +			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> > > +			       sizeof(struct sockaddr));
> > > +
> > > +#ifdef CONFIG_NFSD_V4
> > > +			if (rqstp->rq_vers == NFS4_VERSION &&
> > > +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> > > +				/* NFSv4 compund */
> > > +				struct nfsd4_compoundargs *args = rqstp->rq_argp;
> > > +
> > > +				opcnt = args->opcnt;
> > > +				for (j = 0; j < opcnt; j++) {
> > > +					struct nfsd4_op *op = &args->ops[j];
> > > +
> > > +					rqstp_info.opnum[j] = op->opnum;
> > > +				}
> > > +			}
> > > +#endif /* CONFIG_NFSD_V4 */
> > > +
> > > +			/* In order to detect if the RPC request is pending and
> > > +			 * RPC info are stable we check if rq_status_counter
> > > +			 * has been incremented during the handler processing.
> > > +			 */
> > > +			if (status_counter != atomic_read(&rqstp->rq_status_counter))
> > > +				continue;
> > > +
> > > +			seq_printf(m,
> > > +				   "0x%08x, 0x%08lx, 0x%08x, NFSv%d, %s, %016lld,",
> > > +				   be32_to_cpu(rqstp_info.rq_xid),
> > > +				   rqstp_info.rq_flags,
> > > +				   rqstp_info.rq_prog,
> > > +				   rqstp_info.rq_vers,
> > > +				   rqstp_info.pc_name,
> > > +				   ktime_to_us(rqstp_info.rq_stime));
> > > +
> > > +			seq_printf(m, " %s,",
> > > +				   __svc_print_addr(&rqstp_info.saddr, buf,
> > > +						    sizeof(buf), false));
> > > +			seq_printf(m, " %s,",
> > > +				   __svc_print_addr(&rqstp_info.daddr, buf,
> > > +						    sizeof(buf), false));
> > > +			for (j = 0; j < opcnt; j++)
> > > +				seq_printf(m, " %s%s",
> > > +					   nfsd4_op_name(rqstp_info.opnum[j]),
> > > +					   j == opcnt - 1 ? "," : "");
> > > +			seq_puts(m, "\n");
> > > +		}
> > > +	}
> > > +
> > > +	rcu_read_unlock();
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_rpc_status_open - Atomically copy a write verifier
> > 
> > The kdoc comment maybe was copied, pasted, and then not updated?
> 
> ack, I will fix it.
> 
> Regards,
> Lorenzo
> 
> > 
> > > + * @inode: entry inode pointer.
> > > + * @file: entry file pointer.
> > > + *
> > > + * This routine dumps pending RPC requests info queued into nfs server.
> > > + */
> > > +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> > > +{
> > > +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +	if (!nn->nfsd_serv) {
> > > +		mutex_unlock(&nfsd_mutex);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	svc_get(nn->nfsd_serv);
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> > > +}
> > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > > index fe1394cc1371..cb516da9e270 100644
> > > --- a/include/linux/sunrpc/svc.h
> > > +++ b/include/linux/sunrpc/svc.h
> > > @@ -270,6 +270,7 @@ struct svc_rqst {
> > >  						 * net namespace
> > >  						 */
> > >  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> > > +	atomic_t		rq_status_counter; /* RPC processing counter */
> > >  };
> > >  
> > >  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > index 587811a002c9..44eac83b35a1 100644
> > > --- a/net/sunrpc/svc.c
> > > +++ b/net/sunrpc/svc.c
> > > @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
> > >  		return rqstp->rq_procinfo->pc_name;
> > >  	return "unknown";
> > >  }
> > > -
> > > +EXPORT_SYMBOL_GPL(svc_proc_name);
> > >  
> > >  /**
> > >   * svc_encode_result_payload - mark a range of bytes as a result payload
> > > -- 
> > > 2.41.0
> > > 
> > 
> > -- 
> > Chuck Lever
> > 



-- 
Chuck Lever
