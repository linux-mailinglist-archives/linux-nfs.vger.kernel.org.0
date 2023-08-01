Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BEF76C097
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 00:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHAWv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHAWv5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 18:51:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08081BF1;
        Tue,  1 Aug 2023 15:51:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371KxkZG023436;
        Tue, 1 Aug 2023 22:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KXhEAFDo9C+zUyMQkc5olCzxr4kgdpkLSZinfEDvpBs=;
 b=OaibgxQ5lUHu+Ea7Xe91mamt+15FQ85TC70MYYWWzfZXcqmDNIp4amTnag8Zdr9RD7PJ
 0cUSBvx/iiTpAVqD5afYuWhZzc1f6NmDctJD5bIh8E5yQglTf4DmXGfJ01UDZN7fuE+E
 bv8syXccsr5BVPBOWOzKwFc4jUmzs/05UD1n8+VV9oZzGW/N3ieP4LDOoxu4MBXD/w7F
 WfvunAVykhMh3aRtnqBXPAwWiJUJpZNmMayj3S+b2dunYbeqwX5Ybsa1AOhy2TaZDwQh
 Wzgd0rs+ZNwrPJ3Qy2uKeisdwF9tRbndZaQ7EB+1PO8++2U+3y1c+vRU7TMYld11FW3+ aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2e3en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 22:51:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 371MCPSv000729;
        Tue, 1 Aug 2023 22:51:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s774vf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 22:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8Lt62F3S8vGfmgNqP89A299XI0zbQUmR4u92pUeE9TwrzBpryNeiGYrOwlckf5W7d6jAseo5feAiDc6Rz1BWNZSs+CzOvWO2sUP01xZGQIjzCpWthQ54POOWHPzE47mlotg0ilJBBenPP6Ubsb7aCy1JagQBTzBjzAB4XeBi5KlGdPmIuxhLeYHoJlg2Kx7SDtq8twTVWHYD2egSz+AzY+5xo9eM+YfWUsi7FqeJE4Vfw/e8pbW4MKPmtyscRMGGgJDY7AnZVVUk7M+1McLy3yI6wXcV0dBH+Pepw10/Ga0wWovmv/3jrLaekSWvFEVGUwzBsM8GzA4/nw6VjS00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXhEAFDo9C+zUyMQkc5olCzxr4kgdpkLSZinfEDvpBs=;
 b=i6PGox/+NnyvwKKjEq1I3Q/fWeHBjPSv0m89HT/ImmDXqaBIXIccyIXX0cqYR4EhCvHtn8wSFzbXgnN546dbbRuw64rHc0zokMMbjhXD7u5hDG9l+SA3xbb0gqiP26jgyIIiLOI3EBIxsDI6fwS+77ISm6lgqohCuam7M2KChauq5FEog282DzD1iRsHytBqN2PEEVL/AsaPZrPWzsCkC0aE5vR8gRXk7ZBZR+DL2An2mloN6yWYuY4GvEAp4FYgU1d/uo3s+klBLAx6qkFNRHYrAakHuNX3M8KNPUFYj9YqeeHrGEG2VC2lbnjdYvo41h7WwiW3Q8phjlupXU8xoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXhEAFDo9C+zUyMQkc5olCzxr4kgdpkLSZinfEDvpBs=;
 b=bWXpfzWHnO0AY5/kPJuweMku/8i9KX/Z5rMKGP2I3cyeU+mQpvGGWjPsc0H4ey9tiQ6j9EYGDznk5PcOm77U1QzMBovi/ejBrOi1rFtmuZikcFAUKsDH6VuhQdlm/o2vS8tsLitrWV52arIwusyjlvDosIz2oDPnURXU/pOCz+o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7254.namprd10.prod.outlook.com (2603:10b6:208:3dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 22:51:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 22:51:43 +0000
Date:   Tue, 1 Aug 2023 18:51:40 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Message-ID: <ZMmMfPSFIkV2dbhg@tissot.1015granger.net>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
 <169092877531.32308.10105992729094485900@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169092877531.32308.10105992729094485900@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:610:118::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c45072-7882-488b-81f8-08db92e1e08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5jJ0NA4f8YvI3pvr0Xb8FIQtzzcv9UcwpBUu+5ToVEXIYkvFObSf90AKE3RrsD82AXXdUEsO3+a6baQDoo1nRSOrA9J9pJLO4yczw9SwRCRUfkyEGwS2OnI8frl5yfV4R2hlXdgmpDtQQtNCJRrosLa81XjZVDArifoAYy4vYgIGcU6UEtI5/QL8hxeeKr8U4bcByFd8ZBVRCmWuMxVq4JUDajjTD+C7Av469HoPDOib3W6ho6KQIckvA76ftzlH8dT0d6oVmKqzQFjFD0AOVqYu9FKEerBepcls8n0VL53uCYHRMNltEy53uFq1v38AlM/eEi/h8pvBb78JbwCV9XBAWOsvjC92CSu6d5YRFSVx/PPC0MnpNfc1KBADJTTdostpdSE3pJN52zqn5b10lmxM9cfzlEzmItHmuD/iTXnjgldRWg+n9tSweeUGXifIK+lfbl49fNyImw7QDGHEWNDJQCALgrQOE/hz+czVIH9gOmPy7Uc81b/HS69saEyW0ndvFF2TDKjuQZIU1BdOsWP79hsoq4TKD8rVrYqatA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(6916009)(4326008)(83380400001)(186003)(86362001)(44832011)(316002)(478600001)(41300700001)(38100700002)(9686003)(966005)(6512007)(54906003)(5660300002)(66556008)(66476007)(26005)(6506007)(8676002)(8936002)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?avZoaiDk0BS4VtlpPO/g4DnsSkOk7cNnIc7RIwOPy4DVrSgAeW25uc7E3bW2?=
 =?us-ascii?Q?OHr4DpC5b0M2yufj37Rb5bdDic5uRKYeZ4/HsHTDcqDJuGLoqOVSpRj0ewM4?=
 =?us-ascii?Q?NUHCdFAT4YgxFEurI8X+yVaSrqokYihSw1qnJv9R2gz0miFUIAfVLqHDZk2r?=
 =?us-ascii?Q?vmEDFmJLdibbCSfkqMy3FWpCk79BBkMgl0k3DV5bzGP8Rk3rbnrIwMzkJ09E?=
 =?us-ascii?Q?f+ysMh04S8R3JkgwUl0WBOx1J+QrSCLd23M2sEdsVksKUpiKI+/0hq1M0CmQ?=
 =?us-ascii?Q?CL1dY6uDeG9kqIktFXNlClZcoim1PlXf5vI9YJpV7At+fUfBN6IEgawNio7x?=
 =?us-ascii?Q?Si+sPieKoZ0iJyxuBkZzG8C2VVGNuogg9F7NlJoq93wQrPjXKrXZJrB8p6yo?=
 =?us-ascii?Q?+qFlZrtCfcemsKNRkiPgxFMq+fRxYqcVbl5LtIYxKYnWQBvCDsIJEujta3wV?=
 =?us-ascii?Q?znHpMVOQRzWc1fdU1NENPO+aKMTg5aPQIjG1UemDf7rMj6mJtZ/KINaOonnG?=
 =?us-ascii?Q?/e4jI97su4GYXxS7APDZlcESjshYuFlR1NDA61KoXkGeOTbiuX4s2PAn9cUG?=
 =?us-ascii?Q?nT0//mB19Tsbsm9pB5/Bn1oQmdYkCgwy8Bh1U53zMTjEd4nugfsR0kpdwX3I?=
 =?us-ascii?Q?iGNgW8lsQ1MX3nej13blwq+rcUmx+qWUvN5sSTHuOBKlNbJBHGqbIvIUT+G/?=
 =?us-ascii?Q?UkTpOYCy3Tr39w/PBKSYWqfWgh7FELr2pQFzE+C05ct7JkTHZj3gjBB7kKat?=
 =?us-ascii?Q?lJyowvnWpY/A4DU4/OUChmSqDUOJVjF4cOZ6M8HQNPS+eM99UzBxusO88cab?=
 =?us-ascii?Q?8D4NlI3Foxw8G86YL3Jc/pe1VtIpIuEdOgeWbvrZCHxTfykU9mOfyQ1vHbW8?=
 =?us-ascii?Q?pxI1+xIKwITHI3sB9hUcwRQpeyfaqEj2WpmjCC9KbJuWo64RrwcQxNs9fAN3?=
 =?us-ascii?Q?XyoL2LTWChqtf1l4s0uPoMOG0Zvd3CEQ2fSBAYE2CQNX9SfsBXai9ITYTQ5F?=
 =?us-ascii?Q?RCa3S2rgN8dtl2LFGfQseBOeJPwWM+A87yPOXp0LgMJ515YfKUXwwLp+MiMC?=
 =?us-ascii?Q?c6OvAmApjPJJ7jq5hdzfFPKiBVB4LJFkT0LkuNaLWDj0RHSM2AySqNUp8PW/?=
 =?us-ascii?Q?B6zQABTpBuZuje1a8+EocF2ej68x7LXf259rHpr24Dp0DfXDauJAbEAEB6Qx?=
 =?us-ascii?Q?Ogc5LzrvM2xNl0O6Rarj0ZWCJnevR1pfbtDmqlW3Dc9m77lGHC4J3RfMtoL6?=
 =?us-ascii?Q?3qNRr/gBTpsbHrpzu9oo1iilOdKEcpngo8kbFtCaWP91MB93AWtaeMTE2Ytv?=
 =?us-ascii?Q?GWfY+a2dmxGWIW8sBFcgcgYWxOJv9Y+Uprp78k3GqKmxue2mwb9Qczqe2Ark?=
 =?us-ascii?Q?soY6OmOGlnhfTGD/qtD+P9AgsCmSx9ts9tbiM+Jij9Kw1qwNCWAD2NubWb7K?=
 =?us-ascii?Q?IcpO1p+UNyGtU5a8ePbMYeoDuaLdM3CoMFjktVBU5tinWHccAMcRyT8rZU+F?=
 =?us-ascii?Q?aEImwDNRzk6eSlNFtGQa1oprv6K9UtXsC41CeSh3c2hkmoH4QBKX4nNhrRnx?=
 =?us-ascii?Q?H7GY5aEzCsE2nirKolavE4Wqo49HJZ9TINo4vbwEriqAUcbBe+tvvcbKICFq?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P1MhHD40axEdpj7mWEaQ71WsqPGVBGKBdORv1a/X6HKfeqdfphXI4wAYCEt+175wIwCXI43MS2K1s9wrxJH0V4Ja5wILF6vTtD6ED97hBUC0yqK1txI7hInyEsY91qz671f1MJkMNfW69RD1DnoliQHFxWxlbE4KkG2cfdNeipxeCk3sDDcGQCM89PUDA+Fli4Y05SPvOK42ZOyxmzkcmBJCCvF8vy44fAJ/xgywZsIkUWIy1EPNDWQ0cgaQhK/Iljz30i9/QjD4VowqngFOr9Rc+zP4ulvWcKawI4vXOtsc3CpPFsp7clU8qxz5iWLbyTTSzAON3vBTrAjrLG0uzq4vzhsMRv7UYhbL/QyJD4h6XTCvY/VBTHEdMqQxh2VcsLkd/uDMFoBX7AvFo4lyfJK4s978COKuoG+ioaf8MTYOq5yL9Qp/i8578iNm4ec2/dzDQoKrTckI4hv7oSsBHnhAnrSom+NANgB8MQlnimbG86ZdgLJS44X1BefrZMMde4dEOatuVmB1TJlT2Q/65T5JRKcXmCqqFFtON8lCTLlZvzgct+lHNTDd6UKzIsi0v6JCHxEQr0tAxMJ4B7FXt8iGiT5MFboA7GZzPvD/jI2tWYMQRfeor2B+WLDAtNJ1XuKpI95e63BIatoCs/fE/IRcU93U+ZpjH+TrpVKY37Ic9msUDvdvBPxW3sPjQt20G2wcqHj/p0TOYj0WebhapLGVfUaiuU6W/ngaxCh+gVpCP4ntEvd8HTNaNgN+m+T62ZRFtP8B9Uk8Fy7T/91zBQ4jn2RfAQ3tqbZSVJUMdi8jU14RBOQiMIWXUNGyVggd9q+YF7jyzJDjMX0c7qE2Y6x5BxnvfOV3PFFsVZzng/jnHhGTUzvWPVrC3gb+nnF2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c45072-7882-488b-81f8-08db92e1e08c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 22:51:43.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOdcQ2gfetMiIASsISsqOYO26sEyFeyBQ3HM8WeUCOn1d0zjwD7ZeNAMRxhux3WIt/zc1Bw2edeG4YdDjB9fZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=710 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010204
X-Proofpoint-ORIG-GUID: 0MRjo0wozmdgT2Czo80CZ7-5riiCPCOJ
X-Proofpoint-GUID: 0MRjo0wozmdgT2Czo80CZ7-5riiCPCOJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 02, 2023 at 08:26:15AM +1000, NeilBrown wrote:
> On Tue, 01 Aug 2023, Jeff Layton wrote:
> > I noticed that xfstests generic/001 was failing against linux-next nfsd.
> > 
> > The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
> > would hand out a write delegation. The client would then try to use that
> > write delegation as the source stateid in a COPY or CLONE operation, and
> > the server would respond with NFS4ERR_STALE.
> > 
> > The problem is that the struct file associated with the delegation does
> > not necessarily have read permissions. It's handing out a write
> > delegation on what is effectively an O_WRONLY open. RFC 8881 states:
> > 
> >  "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
> >   own, all opens."
> > 
> > Given that the client didn't request any read permissions, and that nfsd
> > didn't check for any, it seems wrong to give out a write delegation.
> > 
> > Only hand out a write delegation if we have a O_RDWR descriptor
> > available. If it fails to find an appropriate write descriptor, go
> > ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
> > requested.
> > 
> > This fixes xfstest generic/001.
> > 
> > Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v2:
> > - Rework the logic when finding struct file for the delegation. The
> >   earlier patch might still have attached a O_WRONLY file to the deleg
> >   in some cases, and could still have handed out a write delegation on
> >   an O_WRONLY OPEN request in some cases.
> > ---
> >  fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index ef7118ebee00..e79d82fd05e7 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	struct nfs4_file *fp = stp->st_stid.sc_file;
> >  	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
> >  	struct nfs4_delegation *dp;
> > -	struct nfsd_file *nf;
> > +	struct nfsd_file *nf = NULL;
> >  	struct file_lock *fl;
> >  	u32 dl_type;
> >  
> > @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	if (fp->fi_had_conflict)
> >  		return ERR_PTR(-EAGAIN);
> >  
> > -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > -		nf = find_writeable_file(fp);
> > +	/*
> > +	 * Try for a write delegation first. We need an O_RDWR file
> > +	 * since a write delegation allows the client to perform any open
> > +	 * from its cache.
> > +	 */
> > +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
> > +		nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
> 
> This doesn't take fp->fi_lock before accessing ->fi_fds[], while the
> find_readable_file() call below does.

Note that the code it replaces (find_writeable_file) takes the fi_lock,
so that seems like an important omission.

I noticed this earlier, but I was anxious to test whether this fix is
on the right path. So far, NFSv4.2 behavior seems much improved. And,
I like the new comments.


> This inconsistency suggests a bug?
> 
> Maybe the provided API is awkward.  Should we have 
> find_suitable_file() and find_suitable_file_locked()
> that gets passed an nfs4_file and an O_MODE?
> It tries the given mode, then O_RDWR
> 
> NeilBrown
> 
> 
> >  		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> > -	} else {
> > +	}
> > +
> > +	/*
> > +	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
> > +	 * file for some reason, then try for a read deleg instead.
> > +	 */
> > +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> >  		nf = find_readable_file(fp);
> >  		dl_type = NFS4_OPEN_DELEGATE_READ;
> >  	}
> > -	if (!nf) {
> > -		/*
> > -		 * We probably could attempt another open and get a read
> > -		 * delegation, but for now, don't bother until the
> > -		 * client actually sends us one.
> > -		 */
> > +
> > +	if (!nf)
> >  		return ERR_PTR(-EAGAIN);
> > -	}
> > +
> >  	spin_lock(&state_lock);
> >  	spin_lock(&fp->fi_lock);
> >  	if (nfs4_delegation_exists(clp, fp))
> > 
> > ---
> > base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> > change-id: 20230731-wdeleg-bbdb6b25a3c6
> > 
> > Best regards,
> > -- 
> > Jeff Layton <jlayton@kernel.org>
> > 
> > 
> 

-- 
Chuck Lever
