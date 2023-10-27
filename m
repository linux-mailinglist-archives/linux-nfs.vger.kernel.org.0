Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D614C7D9D3E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbjJ0Poy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0Poy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 11:44:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B4B8
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 08:44:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUxvY003284;
        Fri, 27 Oct 2023 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8NQP13EsRYLP3PHlDiBPeBozPUX8eWeoRGavZKVySdo=;
 b=VmlPHP9179DArJekqqMxTdEPteCcYAUo55XpXLx0+ZVnqG5l4u0gYVAf79OGCZmxmynh
 xHoGdX/CT6u8Hrtn1Y7auyn+4c7ATU1+hHCaD3MzZpIUV/ohQmS9Mv0vhkKOQOlV5ERC
 7MaMV7PFcD2CuYsDtkSFsMdeXl6hYh+L3TKm2b13d+RI8P3YJ0ffGlFcV682cme5VT7G
 PAgvV4Mm2g8QwdqZUDyEl5q0g3uiGCIO8KtILq10Id2UE9kJsJCfGVwxYoI1hxWRVNe/
 2ozJnkv2rmoIQQZDFOfNcr0oxsNESjKhdfHeenYeHfwJ9yhLRbbNnIifYUZ5240wz7lI fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxmv9r4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:44:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RFcUEE022958;
        Fri, 27 Oct 2023 15:44:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjmrt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4fnXREYVDdBSoVKljhe1URS06mxgCUAwVSMBEpfAlqPZVKSjXpLG/J6PREEMlkhj/KYdW8Ct7o86qFFvjHjdId34ZR4Xba8/5GZ6sQX/EWGZNb2ufxFMKZ9xSdCNa+1YGPnwTWSIKURRRnqGA/jeqg7G+t3KujWHyaJ1+SAA/77u7wQXHwtAgoGvG/ihiHITrlHguySPLDGfoi7ic3xsyWB5lNL2PJNhthxFk+CLQQm7D8N0a+mRMPsMpWgbtAQiBkfgPY9SDiaxADsn6OVRzSnDTaakeMeZ15RuIo0nXbRGy9wQvRnnBkahY/aa/J2R73u+XYEq6UEY/zzctKcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NQP13EsRYLP3PHlDiBPeBozPUX8eWeoRGavZKVySdo=;
 b=mB1J6mZL6UZl1nWIZeUMvqw10kn99aMGSwbNf4Jbuli5JFd2vgO8GFwrBBq+iHALz42fPlFudn47i9Np+Bj9eCzwiOo+MzZd8tLp/Ix6XcMK8IlJIbJJ+yGju9FGIZETNIg0KYskvOEc2LRiUkFk3M7vRvF/0uZiIHpZ2FuVkJgvou9F+yABjIVimmBPsT8niBCHGwPspIS3RU3GyS98zbmbkOe8Co4ltAHXl+biTCfkR5MFSwrkG8WuyMd5no+cO3J70qnyv+1NZpJWh0wUUHARzsX2LG5HqydpjWyO1uUplkQGm+eof7FdBS3tQDg6wV+deFUb9od0J4p+OM65kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NQP13EsRYLP3PHlDiBPeBozPUX8eWeoRGavZKVySdo=;
 b=SNFbIpYeyYcEMmI4rDM2HsZpUU1xBFARggp9QQEsScMVLwwpua5v7q2BIk8HeYP8stjn+3t1BtN077qSglFj9Y4IH8gvZ6CVOXsNM31UB0sColh18ICv/Sxj8/v0L6Ocr5Z+RKoQB9DXD/ocGgaABacrebsPZlvnJrzz9oSUY9M=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 27 Oct
 2023 15:44:09 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 15:44:09 +0000
Date:   Fri, 27 Oct 2023 11:44:05 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/6] support admin-revocation of v4 state
Message-ID: <ZTvaxWodP4rKFkrm@tissot.1015granger.net>
References: <20231027015613.26247-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027015613.26247-1-neilb@suse.de>
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH7PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a120f9-ca17-4f61-7bc7-08dbd7038f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zl2HBkE1iIWFO8g3f7pJ38YmaqAjXMg8Rp/dRSEnyIRgtJQX+nKEU47WOvrchVJNbHIEcSk/fa/c+lHmjA5sFCNlXpNx7oCxzKNi3Cl83GKMRzBc/sKfvKMuDoeQPhwvgiRgRlnKxMXFiP7j5WrYgkrtJIaJXbAu9W0AUz/e4HCJiDxAcfIm1TsC2+OszMsCulteHjmAGhtMPPBN9kcfW3/hh/PHVeeFLdbGUBOL0xIvGhZCMQSCy1xp2sksQ1aLSPTGFKSPphT+ncxg7gR0FbOroc/gHmGdNbnk4KsSIOlng63JMVt73bZCuVm2aKF94lv8tfp+KmG6XdejPIldRPU0LPo2OqkH3QsuZIg7ntXWJAz3+ymBJ1OChjn8Npj1h1WVn/tgJRcGN3Fn5XR8xi6HEKhUZeMCJdVzF6TFw2MQFIN138J8Ap6iDErTPTvT9rhI+aKNUfWxM4e/7C8R61oHykoWe15SUvdr1sh29+UGWtQcO2uMEz5OhACRT5DPSJsqixQ4A8q9RB72vBHgPG5RCsnehZZG6bPsZIMI9LEVm8wq9bkr6pPrS8rwIPxo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(478600001)(6512007)(6506007)(38100700002)(6666004)(83380400001)(9686003)(6486002)(26005)(5660300002)(41300700001)(54906003)(8676002)(8936002)(2906002)(316002)(66476007)(6916009)(66946007)(4326008)(66556008)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rS/YbXvxN6TqI+ATkBefu5WB4gelqIjshXAd6UQf2C88GO08k80cFd94JQ47?=
 =?us-ascii?Q?qZtvU5dtsWOREE2AGOl5XMXLdn8T3nm2vZBMXAENtEm/FKL8huOcqmu+Ww/A?=
 =?us-ascii?Q?zyzRCq0HdkbXvI5GeYJ0WeGxSzVaunYzlmoMP4saY+I3y77+DnbQfdhmKd96?=
 =?us-ascii?Q?zisYKkmK4UQTXCAINA/Tzl8axivjFfAmXW+EIU36dExOM3D8s6uQDIOArbP6?=
 =?us-ascii?Q?NobTFEMWvLgHhMX7qG2wAINd880HGzlfZU96MwJXWBZxwKKxBkgTw3wMKZWy?=
 =?us-ascii?Q?wy26PtK5TnqUoA92B6Dba6v40uMYGy9ZvUj2j98Ufq5LsrjYaa8oUXSEUoMJ?=
 =?us-ascii?Q?P8IhlJAA1zZpXSRjSdIPu3M30S0fT5Ammcrj0PfUNU7xAlIkvacc1OpsTjKo?=
 =?us-ascii?Q?30hNIgLWTIJMbSBRF503If9aRJUTm5V8SAl24UwiC3FkOdYI0BWeWAv23z/A?=
 =?us-ascii?Q?ZTz+WaCUtdw9EEtSaw89EXnUNjhpPbtPvX8g6yOY0BP9lf8twpGse4rm75Vg?=
 =?us-ascii?Q?ONAc0kGOdA1DYEgidNHf2O683vqt3CmMvXzxb7RXm2/cd9hT4xNtAeiAZmE/?=
 =?us-ascii?Q?CySmfRoGdZozTC3nj5SYtohJ4cCimEP2rH6xNhUjK7HGkRs072RTRUTtTx7L?=
 =?us-ascii?Q?9t2G4sAOujbx7Vn5xRz/c9v/VsecS0/v+/CRusQXw2V1bLAk7ALBKNnpsvup?=
 =?us-ascii?Q?Zytfb4EWX3C3CIhKOflNR0htizMP/ell/GCnBzR5Wc3oIWS0rBtTGshmcxC3?=
 =?us-ascii?Q?R7yVqoOe/WA/YtDa9ukJkuQiBwKz7T7QwLSNIjCQE4vkY2nwQ7dPbmgAVlu3?=
 =?us-ascii?Q?yZf/bJXjG8OU1UK7dHReUUy7oAsA+HF7r6fIFst8eMsAuWjyhotxAH9+5B88?=
 =?us-ascii?Q?K11AyoYnx+fWaTULJdeTrG0ojbLkFaMWWEHw3n+MYmNzC5D623cU2siT+eaQ?=
 =?us-ascii?Q?IhCxmIcaNIwXT3FeEiM8wobHHvWXbK0WMJgowwMm9CR+IwfZ8yla9S7jhg1d?=
 =?us-ascii?Q?FtNHmO3sgEBCDBG1EBdR/hOmTIkosfO58fLH1Dyblqp41x6DwNOZnOe9yFHW?=
 =?us-ascii?Q?JiusWOzxSuM7yZRCXjCHxfmNNAy8KHrdDOhU1fEAMAUvHlYwfJKwfAg9wuLv?=
 =?us-ascii?Q?pnOY0PHzlZU7iQdh308I4xuXartNoF3/R+j0IYxWbmycmllliBeLoaqX91rZ?=
 =?us-ascii?Q?bYfKRiAgwQtiu4DguTZ0kd5HTbpXtO8irVbrmIvj11O7Aksx6pJi2jYGipPR?=
 =?us-ascii?Q?SQJl7t6ijhabAazocL1kSClI96SYWd5RXYroTP6g9qeOSucYQCX0vP4ot0ZI?=
 =?us-ascii?Q?XdvF+OfIxiep98sznJEYbKLnDiTwkar2PE3iaWJ4C+53tUvFlVNM22wA8SKE?=
 =?us-ascii?Q?cUUPDPjKAZXQPtqY0ocGuZ7Wz+Y3tYvn4MjWM2b3P9hGH4QkW9hNdWfSLaFv?=
 =?us-ascii?Q?aYjIVR0Ahc/AEqzpa0zx59XO5WvqWVWVAyvhy9bHPA4KRJoVHUP3eavBsLM5?=
 =?us-ascii?Q?zhvxdI1gGkVRavp3LCbaQ8Sr5h60KNbztr2xJSnVW8rOKjuWouWL6emXmZVI?=
 =?us-ascii?Q?Qr/MimHZ3aHK/YTMrRnjPcpTsZoIPSD2JUyvg71I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KZkiRo/xyFoFZHJ4SVt3CyNRdjcb7bk2JIJFwCzhDrPQ4doVkMgHDh8MzXuhOUssgsiAuAI6VhRDDf9LIyfXWZWwPWrUMKQM8OtDFDemoZfnYMvT9HxWwQeHvfTJhNyJg3MQt3GQj2OFGATpI9cfzFu4wjhV2scckSFUXhG/1+2PvpBjcoPPRT794xPi0Y0p17C4MnO88D9WfVI0P+yXc0SWGBTmr7F3dFzANu9I9JHtpRDyaBe9dfW45QVa0nb/UOL3rhyykZNhBHrn9VBnY25Tx2tVxH7acMAePDUaLS4u5pk5uM2gByrz6LdiwUony3scajlwnr5/sWe+1X0TFNJaFCAE3LsU0wnlZwvJCuwHh4x+Cv4TocZo3sXedqNAWsdKGCvrO4rEW4mEdcuhRUg+RQy+4hJ/+1Mn07amsHpPBOlg2YZadIAZVROuRlF+JG9BQtHnMv7OGhq6/W/sSQVrwYsqH0nq4bCgTrtzBzlhXxzSeIijMZ6yoQw26DzlSGg/YnIvbFgyktGNdmINIhdHNFIX4Deg23M+Z2JHm6DMzG14rRHd3qxiPHMFAfuBv7t8DTaDKyKx4nmFObg5Z4OLzaiKblm4jXDBduqZKhMSBvsaYmree5iDySSBvruF3Ih5M5FO+g0uCGThAV8HeIB4byAidlEX3OqyDhwh+q0mVCXzq0LFTqlZk+gjD3UNnPOa63b8cckW3J7LSkpQEiQxr33T8kRhOM/azsdtZqJHCxj8qi0t27hZ3U871lafiNwWgYD7bVFWW1oQZuPfSIZdGAZVgWgfzJLD43PEroqP/cNGX5i90VT38qAv6INgGHcWwDfEbfHQzSBGfazMDYcXMXNGKua56PM0UTd8d8iMOwAoa7UJlE4vScuG4NTS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a120f9-ca17-4f61-7bc7-08dbd7038f0a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:44:08.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3SkK1qlGZjEVDqoQprs69Pbl/EWz99TtNDkB/R1OPQw389sHi/l+NNtc+r5SBoN0DH4J2WVH04g0BZ2P+2b3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_14,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=738 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270136
X-Proofpoint-GUID: sM_jmF7ck9-Job5nmsRP9KKRo3KSTUWP
X-Proofpoint-ORIG-GUID: sM_jmF7ck9-Job5nmsRP9KKRo3KSTUWP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 12:45:28PM +1100, NeilBrown wrote:
> This is a revised version of a patch set I sent over a year ago.
> It now supports v4.0 and has had more testing.
> 
> There are cirsumstances where an admin might need to unmount a
> filesystem that is NFS-exported and in active use, but does not want to
> stop the NFS server completely.  These are certainly unusual
> circumstance and doing this might negatively impact any clients acting
> on the filesystem, but the admin should be able to do this.
> 
> Currently this is quite possible for for NFSv3.  Unexporting the
> filesystem will ensure no new opens happen, and writing the path name to
> /proc/fs/nfsd/unlock_filesystem will ensure anly NLM locks held in the
> filesystem are released so that NFSD no longer prevents the filesystem
> from being unlocked.
> 
> It is not currently possible for NFSv4.  Writing to unlock_filesystem
> does not affect NFSv4, which is arguably a bug.  This series fixes the bug.

I agree that this is a good thing to do.

However, I'd like to migrate the "unlock_filesystem" functionality
to the nfsd netlink protocol first rather than adding this support
to /proc/fs/nfsd/. I don't believe that would be a difficult pre-
requisite to get through.

Does that seem sensible?


> For NFSv4.1 and later code is straight forward.  We add new state types
> for admin-revoked state (open, lock, deleg) and change the type of any
> state on a filesystem - inavlidating any access and closing files as we
> go.  While there are any revoked states we report this to the client in
> the response to SEQUENCE requests, and it will check and free any states
> that need to be freed.
> 
> For NFSv4.0 it isn't quite so easy as there is no mechanism for the
> client to explicitly acknowledged admin-revoked states.  The approach
> this patchset takes is to discard NFSv4.0 admin-revoked states one
> lease-time after they were revoked, or immediately for a state that the
> client tryies to use and gets an "ADMIN_REVOKED" error for.  If the
> filestystem has been unmounted (as expected), the client will see STATE
> errors before it has a chance to see ADMIN_REVOKED errors, so most often
> the timeout will be how states are discarded.
> 
> NeilBrown
> 
>  [PATCH 1/6] nfsd: prepare for supporting admin-revocation of state
>  [PATCH 2/6] nfsd: allow admin-revoked state to appear in
>  [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
>  [PATCH 4/6] nfsd: allow lock state ids to be revoked and then freed
>  [PATCH 5/6] nfsd: allow open state ids to be revoked and then freed
>  [PATCH 6/6] nfsd: allow delegation state ids to be revoked and then
> 

-- 
Chuck Lever
