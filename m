Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8CB7743C6
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjHHSJp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 14:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjHHSJT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 14:09:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D11B51B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 10:11:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DAfHK007274;
        Tue, 8 Aug 2023 13:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=SoNXyNJG5+RhwUYPL3n7G8+AbaTl0iRNF45s4QY1R3w=;
 b=Zn/cUPLg/d5EqxUswQjJCzrsLcvwxysDxMwKwBMJLyZG85rr5t8tr2Xi2m8G0xFb07uS
 Lc/LUREi2uAwvsup2HJuTgvcSMWANixwiUP1RLSMBigK7LXasWUTrxUpKM7HU85PbbH5
 zr2lwlVQCAb9M8xuOkfkOmUbC2duKaiIoHIF8eCbFh0FH2WQJ2xb4GxlQFc/AzM83qlv
 eZUi2itkestR9XC/UYSluoCjbLnAsbTkup2iHSsR7CuCj5crZFc+t34ZDXarGHu4eOB+
 OblOgaMEa1pi2K8ygeoTnou25T9b4mEB50M3/OQJMzbNAojtuNU7NGtSzD2EAnCY/wVN BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u546w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 13:25:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378CPOlS032764;
        Tue, 8 Aug 2023 13:25:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvc1me7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 13:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La6blD73NP4ZM/OPWIFfXUlBhSYapHLH0vHC1TswsH2FAFZ16UsjFdRvxnI45Z8ptEodUm6sIZfJVbTKwAFnqAZMIGga/C9x7ALdemP8X4r4wx6e1PiW7JXeyugy27h0NogfXOr8Lu5XjkOmH6dcbwLmniYz7yC6no1FvSEMof4AOn8FzOVdLF/V0m+NNtjZdVW8XVFHTm+RjRAUE/Reh1r1RkHBOzGhwOHRaBaE/Ze+Q9mY9FjKvguCZL7AHxKlrh3m2awGF2hR2yZtN9o3fzIeTuo4IYcIDXEM2R8aW2/v/h8OqcWs9nHnWzpK2o07IiuqLfsxDRUGAv796YvnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoNXyNJG5+RhwUYPL3n7G8+AbaTl0iRNF45s4QY1R3w=;
 b=KdDJRk2kc2q0R6rL09Kf5XUqJ6t7+r8GXLBCWGRUf2bqxHiG9rhacpAbN7XJo4Qv4dUoLsq2GnSwq2RhrPuFhABlq1av2Sl2XTr0iGiXuT50wsIVLi/KTTKO4aaQBHqCxbUGvZoeKpMNGN9cTiqCgG+s7C15QwLSCZUeBM885WbGx5p6iP+8+n/vIc8CamVlfyLnG3g/BkYtW2XPVvp4yctzI8+TgNZ4qaLTCgMFj39HJ/+l26eX5A4iukENV8GrW+QwPH5OeUvH2i0h9sZNiFNUAdKoD4t6FLGqup4vIUlu/fdifRaDEIvKjbQ3PFd+IzdWN/q6LlS6yJHtth/qrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoNXyNJG5+RhwUYPL3n7G8+AbaTl0iRNF45s4QY1R3w=;
 b=Scv0mKldi5ai5kCh4yn70u6xhIscMSsbdj5Tuon+ZDl7DbhVXXRwCM21dGwYalQUBsVXDDhdKCH7FTsWH/TIRq/yCavY+h6w7OtxG4t0EeFhoN6Wzmpwr9o9jeHuD7Uxab1gxo42Zr+EZjOFNN8gOFKEw97zfCoJKI2+2X8eJK8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5018.namprd10.prod.outlook.com (2603:10b6:610:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:24:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:24:59 +0000
Date:   Tue, 8 Aug 2023 09:24:49 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, jlayton@kernel.org
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Message-ID: <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169149440399.32308.1010201101079709026@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:610:cd::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7bddc6-fab8-4a95-d9db-08db9812dd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZRRcO9MnABxUKzKjySm0KOVC+wEpkqllF8JC7JeaLRd4L+IWQam4uHN+FwgTllODvgzvokpWgkEPoY9PWOXTSqqtfzvPOioei1edIMKkV/qhYNDd0F7392qgTwMnSF9B+AouvEOw2T4eQ85TuQFiRXld47rOxtiLOyUEQzbjf07vKA1xNEDvI1N31DRqIb3XlpgjHmPzqSPWAqphktNSs1qWyfnTIMpa4fP0fp/DNf4N9LcTIgQQDKuFu0b9LM1PnCov/+PStZ5oQm3Y8yPnIUD5elx9bruKLR0BTcRn1IY1DkJ57DukxTqEUxzNECDZuI67H/fj2qJ4GpSAsEkmeILhrl+uQguA2HOwsg9++hjm92X8NvdTJjQhJDoukKruV4pkUfzn+OM7S5z8lWn7dMPr+fsMNddkv7kfxKwA/vUXatmnfznijcDxRVpFyDCxKwUXwnYkFDjaNgPr1SoTd2WUX/XCpevpAGb2Q3G+z1iyMep1QZaxYTY7hHVRlRWHYW+2n4fzCG9XtAmfHGii0Drzp8HBO1kwl5VPIOk4FuZjBATEipCJ5+GDd1cYoDMRll/18SkQZCtOyeUN6qgGznfZUbORGJGFUitrxmZi2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(1800799003)(186006)(6506007)(26005)(9686003)(6512007)(6486002)(6666004)(478600001)(38100700002)(66946007)(66476007)(66556008)(6916009)(4326008)(316002)(5660300002)(8676002)(8936002)(41300700001)(44832011)(2906002)(83380400001)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Ap9RkI6JBZfaL21JjxJfF3vYwp4S9vGyJcURoB0nMKniFDUl3M0Fl2CE4NW?=
 =?us-ascii?Q?BPkNnELIelL7Pob1WdVN5Wzik7KXQmL/4au5hdmLe9StEodnEwur1+Y4j5wX?=
 =?us-ascii?Q?QFktYMXsXLYAnJNazrk1PyJqY2u5jejJR8+G4QOjJwAMBY26h8LHpxYEaMF2?=
 =?us-ascii?Q?cECOj5jOzakOZqr9BXL/B6iBa/LZqYRZx3j9hYKSORKhR1ZiTnYQaseu/Lok?=
 =?us-ascii?Q?52X5f6Q5I2Co1Lhnncwc03LqYnXGFxvG0f9AFoVuowHnT1JD2bY2czD/3rLb?=
 =?us-ascii?Q?CCFd+SRIZnN118X3MLmJBeoEwCBqqfuv8Idn1nqPxrayn210w6SVuyzsE3Oz?=
 =?us-ascii?Q?b8FyiN390wcJ0LldnpfblQsu75bJ87D1IWTMPKNe+SNI0xyPCaTDOGeVZ4kc?=
 =?us-ascii?Q?G1IHnSSGL+2R0jbHAxrOfuewwPcvsWqBdS/G6mhfsva5pOlcAGb5PoLL9/vq?=
 =?us-ascii?Q?X0BfLzeL4APJFG5/N5b3dg3nxdWOvI3vXmPWoJeKwiNZgl7csqFEpYbairqU?=
 =?us-ascii?Q?2opqXDZ7SCPqalxeBtm2FzU+gZmDoWjYwuzcnlPFsknmnwWE7Eu91hNSrZWo?=
 =?us-ascii?Q?Coq+ouD8P/5267CzmHAJ1iIX9QzvUHO88TveqlEdxfgVM4cln926XVMHAJ8E?=
 =?us-ascii?Q?X9qR0U6VcY0GYBhzHiaTp0WnkwJJQr4EpUjNZhoOFgss3FdZvAmsRR/Qn+K/?=
 =?us-ascii?Q?XVcvFcPtnZvrN+6kN1cwC1zVpAjWEGKocvqmThQqEIyz72uFko1bQs1u07NT?=
 =?us-ascii?Q?+doCPV0FMMv0EdSeC2X4Wl7QZOzgr82JdYlYHA+Efsqh1xSKgoX7IZAk7AnK?=
 =?us-ascii?Q?7St2Ou8FjziKGR3SFIkescZVSqF1sVlYRDUa0q+CurhElqekt/OGklehLwZj?=
 =?us-ascii?Q?F+wOqYWuodZxvZkujmB167ZP6EC1akvKYnquSdMyKyc5nRwHWGkCaKmBYTqx?=
 =?us-ascii?Q?n1NEgBvCkuAIDRygFZhSwAeWe4Lt36dymgNL6bDCEVQ/ZMIMRS033pS0XYro?=
 =?us-ascii?Q?MxuD4pDZIRPtXP+O+1RY1orRps1hthwVi0GtkVWjqG3kvytXkDRr/0VcpjOR?=
 =?us-ascii?Q?VhVk1YYojckW8iTkBZac3JyA7FsJhoWo92lTEFxgNaklOpIOQNjQhpqZnyGY?=
 =?us-ascii?Q?n71EZjtDskVrSBD9ZMW51skv1l4rIBJSbiDnVDdRe3SAWep4ai8QchOk8iw4?=
 =?us-ascii?Q?6QdzoqOvwl8ivm3Epz/cf/rVGI/v3539p6A0DgAK5Ni1c3wdjbFEWFHzZVEC?=
 =?us-ascii?Q?OQX/kiWJrITrA4u1Ky9ZKBZkNW5ZuWYoRI0w0Ls0/X1WVxnDmbX2JOQ/cZe/?=
 =?us-ascii?Q?+HwWAecFycYnrEDA2z5f17t9FVQtb0iXhkjTFcUaM+Ov6ImZZSM2qWGtx5J5?=
 =?us-ascii?Q?93AHUwC+4N8CnZ1awQlLkcm3asZPp3+qbXJMU5cDgQVI+ApGJ9YY5UIlqP+9?=
 =?us-ascii?Q?nQYekyhyF5N1ZHNbzU5BIK2pDKlwhOHFnWsszUbHuNd8AZNproOz7GRyAk2x?=
 =?us-ascii?Q?9s7n9wOFiZs6t6ObyD+2Ws9sXIb41Z6+bPp6Lp/6m3sJCT8WCUAg4UWtSeQh?=
 =?us-ascii?Q?vHmVdUg7xEu1+fMW6SoO8rzDgQlOn7DwzGKS8GUNabIvG+CcP/fCVaMc0vxz?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7G2PaAlN61NIJ2Vmp5HQb1wscK2SLDaO2VqPtDx9y3wXiyBYLFaKm6RJ7P5TX7rVSoKlqBA+ZEpnfWXdQckQ38QeQbGnMYO1iQdFTcekKsT1nV85Y+y/byHb0CQTVDNn2w9AqEJ/vUsUesiYEq8o3XeEmgcDqde7XJbbzEHGO1eGg2dY66zAA3RK9i2w9UadGVNfqi3qR5qrDbYX2paD5QblcAib5gSFqVBSTcm+Di7Nrn7O9Vg87JWH48sgErqz08yeMUzK3wRMnvcywHYkHan2rVHrsJwsE4SzS8/kDXt2iEJORoWa/NTvZLiRto5sAp4IbnlRDDw6c3rLVbBFSi0ioORQnWbyyPpGZURI8LvRGJGZbxHXFxT0EkTrdA0EROd6eCY5Pk7PR8CsbryT3MYc38asVWgpsPHRm+6kHhwWJV+HuDojbvuqDJoPKtHgj3q1PDTakPEvl1Nmy2Uvhi4QfxZSkEnZBhg5kH5YHarMjYrcJEc1IBp0c74o8tgEmERnlRFRrnrlq/HNDS11U9vF9yv8xHymBfy4ucn8xPRTOLDY6sxVVV92KLjEWYS7Lkxo11avWEKtxg12lcPanZlmVVViw1e2FpWKRwcuCm0YgRvP/f7itDz/tE/CR6+7PpcXN/T3yRcetWr4ufsLH1aWMmKJhSdzepf6r1Dv+nMJf+5uDYBO86g7BrNF04wx361WtsEuESim4eueoZV1GWVTp4o5a2u5aac44ym+KHjyr9oC2CZTBiSwl9+I4YALtviMNqmQXY+JiZL/Mh8hHdGSVqi3+7h16lu83S4o8nc0dvtmIII7GikWXGBMAK3dvH1vA6E68gv72cRjyPgThw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7bddc6-fab8-4a95-d9db-08db9812dd2c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:24:59.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZldMrHm5KtDb4jxKOIab9CWBi7nidrJ9RhZvTFJryqqkR41sxIyv/yQESBoVoRGR+r9HWD8xzrJ0ltinrboJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_11,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080119
X-Proofpoint-GUID: nDjRo3BTZtfnD_b4S_AFCFufT7cW44L4
X-Proofpoint-ORIG-GUID: nDjRo3BTZtfnD_b4S_AFCFufT7cW44L4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 08, 2023 at 09:33:23PM +1000, NeilBrown wrote:
> On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> > Introduce version field to nfsd_rpc_status handler in order to help
> > the user to maintain backward compatibility.
> 
> I wonder if this really helps.  What do I do if I see a version that I
> don't understand?  Ignore the whole file?  That doesn't make for a good
> user experience.

There is no UX consideration here. A user browsing the file directly
will not care about the version.

This file is intended to be parsable by scripts and they have to
keep up with the occasional changes in format. Scripts can handle an
unrecogized version however they like.

This is what we typically get with a made-up format that isn't .ini
or JSON or XML. The file format isn't self-documenting. The final
field on each row is a variable number of tokens, so it will be
nearly impossible to simply add another field without breaking
something.


> I would suggest that the first step to promoting compatibility is to
> document the format, including how you expect to extend it.

I'd be OK with seeing that documentation added as a kdoc comment for
nfsd_rpc_status_show(), sure.


> Jeff's
> suggestion of a header line with field names makes a lot of sense for a
> file with space-separated fields like this.  You should probably promise
> not to remove fields, but to deprecate fields by replacing them with "X"
> or whatever.
> 
> A tool really needs to be able to extract anything it can understand,
> and know how to avoid what it doesn't understand.  A version number
> doesn't help with that.

It's how mountstats format changes are managed. We have bumped that
version number over the years, so there is precedent for it.


> And if you really wanted to change the format so much that old tools
> cannot use any of the content, it would likely make most sense to change
> the name of the file...  or have two files - legacy file with old name
> and new-improved file with new name.
> 
> So I'm not keen on a version number.

I'm a little surprised to get push-back on "# version" but OK, we
can drop that idea in favor of a comment line in rpc_status that
acts as a header row, just like in /proc/fs/nfsd/pool_stats.
Scripts can treat that header as format version information.


> Thanks,
> NeilBrown
> 
> 
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/nfssvc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 33ad91dd3a2d..6d5feeeb09a7 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -1117,6 +1117,9 @@ int nfsd_stats_release(struct inode *inode, struct file *file)
> >  	return ret;
> >  }
> >  
> > +/* Increment NFSD_RPC_STATUS_VERSION adding new info to the handler */
> > +#define NFSD_RPC_STATUS_VERSION		1
> > +
> >  static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> >  {
> >  	struct inode *inode = file_inode(m->file);
> > @@ -1125,6 +1128,8 @@ static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> >  
> >  	rcu_read_lock();
> >  
> > +	seq_printf(m, "# version %u\n", NFSD_RPC_STATUS_VERSION);
> > +
> >  	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> >  		struct svc_rqst *rqstp;
> >  
> > -- 
> > 2.41.0
> > 
> > 
> 

-- 
Chuck Lever
