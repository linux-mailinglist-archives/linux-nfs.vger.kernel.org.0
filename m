Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD427EF7F5
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjKQTnt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjKQTnr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 14:43:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E94C10D5
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 11:43:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHIO9tl007836;
        Fri, 17 Nov 2023 19:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=yIN6YPfKhZZ0Je4IqDt24Cmc5glXtp9RTgB/4N41ufs=;
 b=OgEdJ/yWPFJAN89yIZwFc+73P5pkXv9Spc7JJkxkI1HQUpYI6ld5FIAiBwtM6ds6g2d+
 XjnITs43KdQh38jlFI1N1fVQ5ya/MUmFu57w38zn9QombBkOYYdHCI+ItCtbdLyo/zNW
 0MetyIYP4zQvNT2UaEzBFJRK0iDa2oRIX0DkJs19cLNahw3AskrJngD/fRmCzHMJT3Nu
 wNfAt+sBXTxpvQGlVZni1VGJougX3Cb31pEu/w3ZTNlfPlVmhZ0OiFmOJXoO0yqF9UMl
 E6EKs4RvbeNgN5YXwbn8bIYZPRHuZk4aRvZ++MwUGKd7OTE8jIA+4SXVX7hD9XDpIkbH gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjx5m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 19:43:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHIbY0I022925;
        Fri, 17 Nov 2023 19:43:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k9203u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 19:43:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDwG8dfqahDCXlWDAxJ8Dro3R9QqmW7hKkyUA3FuwoXKqvcW16b4msjyJXjVi0/7hxLQDWdn5MbU1OVAp4Zz6eRxwnYyezaVKsdJC5GuAwlLNPz3vsYqfSkJluZu9W5V4io1pE444s1xWQLc9zQij+2de1jmI1eQHI9b/MUxbDAfF3wTnGp4LYoSsmFnLGnA2t2/t7pih9Ha76fNZdlF+y0QC3DUHpLc5nmlYQqpT/Am2fsDOfTHC6GidqngHRhjKawfkcPA50PPS9FHqV4Y5wdEpvWz+aMTRVXQFv2AK6k3+HaagQqO4aqTtEDRQ0BVaL1o7gdPfDfs/AnyHmPeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIN6YPfKhZZ0Je4IqDt24Cmc5glXtp9RTgB/4N41ufs=;
 b=L2nZGM3geUXL/JUWApCDXbZdx6/UFteI/BiMX5QU6S/CK7UMCx3A8z/DIM5KyJSOWS0YMr7Al1KIIdjvDVbJzoxvLHlPZKs05xmMbfWFx6d5prFymbcpSmZLmn69urs+9gSyJG3LnRl1z63nljrdJkNpYIsfc1kXvUcwU9GTPvUIM5LTGflSV02C5ZCLmGsjy8kj2FfmFiSsklcBYGL5wA2lO/QNCe+iTOc3lpVhxrfYrgQZgJcuWNaidHQrfaV4hFrV3LVyKcUSUtE9/kLtjbQK2TmaKKmO7GTXxdNM2uviI3okqvNNb9OemLLMNSx6/o6xv1M+sDgw8rNHIicbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIN6YPfKhZZ0Je4IqDt24Cmc5glXtp9RTgB/4N41ufs=;
 b=BGQA4Gck0fiB5iJXQHtLokPOz37h+MluSaiAZ7Gd8ZPtyk5z1dVP7g5jsg6Xr4GQclXxVu6+Sq4lB7xW/h7oiP5s5IR3lJqBoJhppV1IMWYMoxHa04fK1W2OjQg+IsWo37Xlw7C+ywwN7rqqO/CHw6jtfs0TwAG0aZtdAqt4nx4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7194.namprd10.prod.outlook.com (2603:10b6:930:77::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 19:43:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 19:43:12 +0000
Date:   Fri, 17 Nov 2023 14:43:09 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 2/9] nfsd: avoid race after unhash_delegation_locked()
Message-ID: <ZVfCTVTmNd0cgqcY@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>
 <20231117022121.23310-3-neilb@suse.de>
 <40e3c09538c58818e5ab0c713a49d62304c4c4a0.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e3c09538c58818e5ab0c713a49d62304c4c4a0.camel@kernel.org>
X-ClientProxiedBy: CH0PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:610:32::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd198cc-a7f2-4305-5e4a-08dbe7a56f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/opUxqjOgRdwvxRL3vNIn5kjeUGFPof367KbaEhbHXLKXa+onz+MSewFt8ULDXxCAPPXErDkugkRHRZyIpMrIFKAFdLNd/tP/XTIy7W3M7+I7XL2ukKzv85JxJIj9uOlrnjJZ33/5BhPvTFdT4ZCkoCYcgfGMasZFRdEbDINRPTnhPRsK0doawPT+Vw+9vrnljuVbhZl+ETXwVltvl0/bPTZT0qxS8Cjni6HgomRl6T3J1/iYGDOsFwAlS7VSRxv96jo8QKnJ5/iAn37QBJ8hT+4wR44VJhklgKHbHCnXjcVJ5uksroKHBy/cU7F3ATHE4RK8oDy1mprhctFH/ApYn/PCdXRzzcgmNcBIZsVUKZXQEBFtt/EDnZhZLbzHQCJXkvaBx3BeykakRaEp9aP/j4kTTUSn3Ahk7vId975tzPtLpUw3ddIBEhBRpSjb8oJv8zDuPSfifln3VYeU9z9bbR7EbIqeYHK9iypcf6vGXA1r3RzBx90d341JGghuRFa1xO1G6mYeSYXasFTSibQ/KBcPQJoW5G7tzXk6xL2cMgM7Lj+VEGE8QvYyKkyj23
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(41300700001)(6506007)(38100700002)(4001150100001)(83380400001)(9686003)(6512007)(6666004)(6486002)(2906002)(316002)(86362001)(44832011)(5660300002)(66556008)(54906003)(6916009)(66946007)(66476007)(478600001)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6HVauOQepiNUEhXe1MdSXZnc7NakJjkNL97Eb2fp6ZoLDzTn48JdOn5lu4A?=
 =?us-ascii?Q?fbws/p0IA6UrBxCifpU6GowPRZKhwydXqmZ0w3ce9CXI83pejYsbBvA50H7X?=
 =?us-ascii?Q?NkoTv+/BbsGOUSQSXJ3x/W4C7/1vERl62FK/RtQvB7lxYvuCVTPdgbZfapBm?=
 =?us-ascii?Q?h/AL3rPiAJxvVr1HtLQeUED94J+9Tahp5bKwXa7HDtPkggYmgRSFcbaBMsl4?=
 =?us-ascii?Q?NL9X9jyk/5LvQpvIsmKcMgVUThoBZZHcxlr+hviXxaVBosUpOjrl2OX27CAh?=
 =?us-ascii?Q?ofLUbRGIgOBAva1bW2OSVc6FSeDAwq6vM8UIMof4hr1u8H7G3ZTqmK/2Xy2N?=
 =?us-ascii?Q?Rjf9auIjIV/CJcrZTtO9O/k30D+X8Titw531XWXPlkCdlZs6+VzFSWYPF5Tw?=
 =?us-ascii?Q?8xUxYtgjbXpiOBvqrRvYKZp2G62xnNIsaxTxApM35lCzsZiRvAl/jGLjTsC2?=
 =?us-ascii?Q?lpCXcwlw91SefPG1VUeleeQn6RVw2j8QRGldGuI+V8qT9xigCDr2tp84jx8O?=
 =?us-ascii?Q?VowMJ3Myz4nW6GjrrBUolzOMlEpfe3UdKahWuRkA3NK2M7cn8ikWqajX8IW0?=
 =?us-ascii?Q?q91DcsuQlXQGKmiyb/HGqvKDoQ2QjPU0LVzS9xTv7ue3SXucw0G2svUCCsts?=
 =?us-ascii?Q?3DfiFj/64/TxxakpQED9HNCzofSuktITWbE1xlysu5oaZFZcliz8z66tZpQY?=
 =?us-ascii?Q?1aSTZA9XQKd86wsOOPDMAwbBpzbI2cdUFDK5oiGynfdB/iD0WISWOznbM7jW?=
 =?us-ascii?Q?E5cz4TDeG8e6Tszk6yCFjICgun86PIFdUmHeewupXoF7cjzO6eNo4sZcRiae?=
 =?us-ascii?Q?ptubjnm1NoQvk3qw3rrCAW72zNr5XctOWdhbWakzOt385+VByCYx7Gmd3D+n?=
 =?us-ascii?Q?oXs6gzCyAySbVwwLlGIpePEe3LSc6cbcWJ1oQWq+6qLsdAaN6+webAatrK+r?=
 =?us-ascii?Q?CPHr//9MXqXxF0dv9RlgjkAB/Y++boD2CtOS+9Pws3TxFdS5LYSId2xMYR8H?=
 =?us-ascii?Q?KmPLpY7Rr+DS9N8/L86vCUrEc61DEc82W/quEMclo714QoeX98JDIr0Plajo?=
 =?us-ascii?Q?JBXfGOm5dRS3RbvyQgXOttep/E7yU5a+ZGhG3f95D+ED7opdvO3Ae9SnZrCS?=
 =?us-ascii?Q?mGveBYrV92q38/5TlK8Pqcw9ROIuc9F1Z+0b2R11PwM1aHaNMcdwQ8DpZoQY?=
 =?us-ascii?Q?z5qgWZsFdZ0R/zKJVLWkL28R1D/8fK6XB/gNS4HB64Fcr7pperg/i03eZ2V/?=
 =?us-ascii?Q?NSQvJmi1EXKBCdlKc8plmpujF0izq6astZhpGc5V28cnbiSpVRfSryaXpvNj?=
 =?us-ascii?Q?ZhYXEtGwXcsc0Nx/ApuOoqNxUtxO7/wClaXSKRicH1ueabHHY9gb4C4gV2Mj?=
 =?us-ascii?Q?00W4YI8hi5IBZERihD/ptJPbEhJQpVKodTYbnIBbZrS0sdwRxaPvUrGdoxq7?=
 =?us-ascii?Q?eLwGtxGfHYbRpRa5KrP1trns0GCw/tGjdhevJFw7C28jIm5Dn1TLqC/APX9U?=
 =?us-ascii?Q?19PkRh853OGZ1vvwzqeqa88QmUXdq44aOoD1JR0PS7rNzyQtzX21KWXwMeLt?=
 =?us-ascii?Q?QbNlx5jMNXZJlC7xaUyUIDcr4pur7RzGl1QKSAIGE2B0mQdD0EiQxB3lACYx?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zIgaeFqbhZMVFKhOV72jtM5S6oKLb8bUY9XiqALw3LDotM9kZjq0Bohb4pjjCQY5v30CUStn9Wjux4W8Na3DvsGbDpiJCeism7AAX8tzgCZ2+UK8v9c8SZSSGpv0ZjIKtAH47h5NeAZb4p3ZiR83g912S3/UsV+B+pR8L0C+BBLjXUiUBjQ62tPFlq7swgjC9xgfE7ICTnch9Qw8txrmX43i+nXSGI9wYGRvJMg51hMsM439By5+vZe73bUh5wYvi+f/j1Uax4+RNVJ6zMvI2USmghjwnTWvToF6CPc2gIQtEr11zShyngFpzhN6ASLx/DFhpWbtF5qsLpQh/srfCPRb9t5CNfkI6HBrYGP9cR3BI8EwnPC9megSixc223U9FpwW83YFSZxxHmk/EgkVsu512iHMurypCut+QUalSnnWfxpMWJ8dHz1uaMreiFAiu7O1yJPXh/YFzwvGzo//EUaCLc6JB9zGq8TUzcR4qb+irfdBmqOMvSw/ME3V/iYP/fTbe8DMhoLkq4+lADe9nEzULMvnQhEGlxm84fImwVbwvsY2j2S74tQHutJ2yxU4m62Fe/VlA1g6tm7vtZ6IGw40NcN/a2M5xoHxxiF/sOCIh2fo0r/7dN0saxzhUOuM4aGzXnUi2rJeZsYsm9ZCk4Qm7+GFvlQzk83U7rNUqOGcVeL16Pg4VHf5pz86Y00QVoghLTfEBdNhmLIfMFaANrhkiwuwUpifO0ma0rbIwU+k4reC6g0UmrRjdWXdc6FpSNBelq4rzpIABD/3cGKJ8iMFxe62MAjtOSH9ke6tRq4o/V2f8zrygpWq8SvDAehY1ZJ7jjgIO36I/9L52Nn3hAc4Kl/6uwyuhKR9ZZBB3H1Om8GEdUAQrRekabwbapFY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd198cc-a7f2-4305-5e4a-08dbe7a56f2e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:43:12.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOIyIk2dya+qfn8EzJpsxtBLacFI6xfVytUuW879pTW3dnjeuFtR4m3yC7ggtFAfW4dxrXuF7qCJV6emj33ppw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_19,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=945
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170150
X-Proofpoint-GUID: VCpTMSKHgisx_nbj-sWyF1r9DqeMKJzS
X-Proofpoint-ORIG-GUID: VCpTMSKHgisx_nbj-sWyF1r9DqeMKJzS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 17, 2023 at 06:41:37AM -0500, Jeff Layton wrote:
> On Fri, 2023-11-17 at 13:18 +1100, NeilBrown wrote:
> > NFS4_CLOSED_DELEG_STID and NFS4_REVOKED_DELEG_STID are similar in
> > purpose.
> > REVOKED is used for NFSv4.1 states which have been revoked because the
> > lease has expired.  CLOSED is used in other cases.
> > The difference has two practical effects.
> > 1/ REVOKED states are on the ->cl_revoked list
> > 2/ REVOKED states result in nfserr_deleg_revoked from
> >    nfsd4_verify_open_stid() asnd nfsd4_validate_stateid while
> >    CLOSED states result in nfserr_bad_stid.
> > 
> > Currently a state that is being revoked is first set to "CLOSED" in
> > unhash_delegation_locked(), then possibly to "REVOKED" in
> > revoke_delegation(), at which point it is added to the cl_revoked list.
> > 
> > It is possible that a stateid test could see the CLOSED state
> > which really should be REVOKED, and so return the wrong error code.  So
> > it is safest to remove this window of inconsistency.
> > 
> > With this patch, unhash_delegation_locked() always set the state
> > correctly, and revoke_delegation() no longer changes the state.
> > 
> > Also remove a redundant test on minorversion when
> > NFS4_REVOKED_DELEG_STID is seen - it can only be seen when minorversion
> > is non-zero.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 6368788a7d4e..7469583382fb 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1334,7 +1334,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
> >  }
> >  
> >  static bool
> > -unhash_delegation_locked(struct nfs4_delegation *dp)
> > +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)

unsigned short type ?


> >  {
> >  	struct nfs4_file *fp = dp->dl_stid.sc_file;
> >  
> > @@ -1343,7 +1343,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
> >  	if (!delegation_hashed(dp))
> >  		return false;
> >  
> > -	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
> > +	if (dp->dl_stid.sc_client->cl_minorversion == 0)
> > +		type = NFS4_CLOSED_DELEG_STID;
> > +	dp->dl_stid.sc_type = type;
> >  	/* Ensure that deleg break won't try to requeue it */
> >  	++dp->dl_time;
> >  	spin_lock(&fp->fi_lock);
> > @@ -1359,7 +1361,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
> >  	bool unhashed;
> >  
> >  	spin_lock(&state_lock);
> > -	unhashed = unhash_delegation_locked(dp);
> > +	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> >  	spin_unlock(&state_lock);
> >  	if (unhashed)
> >  		destroy_unhashed_deleg(dp);
> > @@ -1373,9 +1375,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
> >  
> >  	trace_nfsd_stid_revoke(&dp->dl_stid);
> >  
> > -	if (clp->cl_minorversion) {
> > +	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> >  		spin_lock(&clp->cl_lock);
> > -		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
> >  		refcount_inc(&dp->dl_stid.sc_count);
> >  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> >  		spin_unlock(&clp->cl_lock);
> > @@ -2234,7 +2235,7 @@ __destroy_client(struct nfs4_client *clp)
> >  	spin_lock(&state_lock);
> >  	while (!list_empty(&clp->cl_delegations)) {
> >  		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
> > -		WARN_ON(!unhash_delegation_locked(dp));
> > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
> >  		list_add(&dp->dl_recall_lru, &reaplist);
> >  	}
> >  	spin_unlock(&state_lock);
> > @@ -5197,8 +5198,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
> >  		goto out;
> >  	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> >  		nfs4_put_stid(&deleg->dl_stid);
> > -		if (cl->cl_minorversion)
> > -			status = nfserr_deleg_revoked;
> > +		status = nfserr_deleg_revoked;
> >  		goto out;
> >  	}
> >  	flags = share_access_to_flags(open->op_share_access);
> > @@ -6235,7 +6235,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> >  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> >  		if (!state_expired(&lt, dp->dl_time))
> >  			break;
> > -		WARN_ON(!unhash_delegation_locked(dp));
> > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID));
> >  		list_add(&dp->dl_recall_lru, &reaplist);
> >  	}
> >  	spin_unlock(&state_lock);
> > @@ -8350,7 +8350,7 @@ nfs4_state_shutdown_net(struct net *net)
> >  	spin_lock(&state_lock);
> >  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> >  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > -		WARN_ON(!unhash_delegation_locked(dp));
> > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));

Neil, what say we get rid of these WARN_ONs?


> >  		list_add(&dp->dl_recall_lru, &reaplist);
> >  	}
> >  	spin_unlock(&state_lock);
> 
> Same question here. Should this go to stable? I guess the race is not
> generally fatal...

Again, there's no existing bug report, so no urgency to get this
backported. I would see these changes soak in upstream rather than
pull them into stable quickly only to discover another bug has been
introduced.

We don't have a failing test or a data corruption risk, as far as
I can tell.


> Reviewed-by: Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever
