Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEC67A2308
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjIOP6E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjIOP56 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 11:57:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697EE78
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 08:57:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFi7uL026202;
        Fri, 15 Sep 2023 15:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=eVTbA55AT2FUVYFYsTimKwtowYK30TOE+/OcCL+Sdjs=;
 b=UDKf5PT7UnB0O1xcRuv7kN3eEOf97BFKfRiiESVnbuDjhNvW+ycSeo7D/E6i2IunNSkW
 Ob+wUvbJ6bSYOBx3JQCmNpQgz/Zsx9ul5NQIMc41mglxDZWJLPyzpkuB3X6oyWsADW+y
 pJ8EDWsvnIMOgug7XCTDtr7z1N8XffkPS3SOXS07EukV8Vavet4MwOeS2AJRMAk6TgAm
 NpkMZ0lug7zv0wa+rg3vESO/cxlXt6+xuMpdLTRQKBu/a4vGDZ1RIMrS4Azd37UH/zkr
 LNfO86di6QE7lSYAsep1WXUw6gVY+sB7VKz/z6nThZapo6kDA/UJMVDbFBAj96/ejxtR gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7pqypd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 15:57:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFKNaR036383;
        Fri, 15 Sep 2023 15:57:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5ghsab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 15:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTCOQTNhn+niGpIUeo3OTaKscrlrOKVoC7od4ia+BY0KtnToCPRkTeB3TwcNrIwTwcD+rou4DxobCKVLPf1WCnLpV+oJFWFoxot1YsH6Td5VlMPlJk1n21HF7m6Qmm+N5G1ft1e9XrAvM6wF0b5oyhQ8KtrO+lXsg+W7vhfLD0aDoXT7Vowi3fhjky/oMGbzTsudtcMNUDHVELpgzmogGG0BAK0kgISp7fIyOyIRJrKIHPvBPXV1hFzZCQ/xV7pJzNEg/wh/ilzbyLclnVMcDNPQcoYNCFKP+3psOs3j7iQe2ADrWOeAEZTvYnaZ3OeF2fmrF9VXhu+MmxK1AxnYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVTbA55AT2FUVYFYsTimKwtowYK30TOE+/OcCL+Sdjs=;
 b=mLRsUIIg0ruJFVnuRjdfC40JNCgUiDDTdjgRsEaOJJGeWsFVHkNs8tJ3qLyucG0rDDSo81lE1YCAJJUdtT0WEDqC3jqgiKekqYocXrT3mKwQSq9tfO1c4FEkAMyD5HFEKkybt/KQZPZHL0VkNjUbQRL952WNhdr1VDgQ10L4+InqrSLx7Zstjqyl5ifsnqhdx0bmQ6mNB7EQNNkdup6oC+0Z39L07LsihxwNL6Wl6MeUdXTrXhxk5hYCbtyTuYmYqBey8rZO9Y/1ILz6iSu3JD+bHR3PqnzNLUyX4XK8JDK2fgj7DGpuTC79Y+wEHn9gAJ2k7syVe+M3xiNYQYw15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVTbA55AT2FUVYFYsTimKwtowYK30TOE+/OcCL+Sdjs=;
 b=SgNL8IXlhCa9gKKXvxKVyyaXlsO/ngDd0XW56JD2gbZs3QVOJKZ8VbcnOFbJ943nkghiO/csvkId+kK/MePyMZrJpnpE25ywUF6Z7kUNKNXsybjrf3WsSUWogUfa9I1S2GaTy0hzafZbkuvCoqK1fYvkmouiR7UtyGtSeSlAvbI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5954.namprd10.prod.outlook.com (2603:10b6:a03:48b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 15:57:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 15:57:46 +0000
Date:   Fri, 15 Sep 2023 11:57:43 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
Message-ID: <ZQR+95ZeXn1pLivt@tissot.1015granger.net>
References: <1694648301-26746-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694648301-26746-1-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:610:38::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4fdde6-8f5d-4496-bbad-08dbb604812f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dc8bEnW9SgmL0PCFN2rmDENZPmqJ0lj6tNfk29BB9XIkOt3k2RqyEavbo7BZVWpsE+XXVA0O2gM4Zlk7JY/C1jSYCLlSrR6y7/5eW+DpwxlZp/pxjASQJlIteH3yAfdFzXK4umTkZPdNKNc9HO1SrmkQBlNTJHu4jJlTGA3h2NM3TxOLOWU4g4VYWc2jq2TRw9l8TZlgWscvcP4Hs8DmPl3Cm7Q+TrSBbJR9rSOSHEhYYfGm1pWajJpIcVQcf59sEwPAGiBdpq8lAUwo26V1pLL1cgCDsci4e4pjBiAdHh7u5S8jC6xwO46O38zcxtC4e1iEZkE7wnUMhzhjIgcFrOs42jUy+mBhP+q9tgpMCbsZ7NlljsHNbTwjz7s+n6WWkaZT3+ZxkGR8gJH5BC5Jo43xBFmtQczWXhC9QgS0b6YqAS6hceP45pABbLGFVShnpVDA6Z42E/HgTFfwHERg2oFZa4KoalsqxZf7e4Crtu1rH3Wn3co4mCBF+nAqbkQWyUwBpHxw6VmjVP813tzuvoKTjy0+FkIev2kpVdtwwpjbPq9pPCvQQM47VS/Lm2K4mN/ShX54/rlSZkzyV+qgy5KidoPEMpfVsDJM4cEQrGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199024)(186009)(1800799009)(6666004)(38100700002)(44832011)(5660300002)(478600001)(2906002)(4744005)(6862004)(4326008)(8676002)(8936002)(316002)(41300700001)(66946007)(66556008)(66476007)(6636002)(26005)(6486002)(6506007)(6512007)(9686003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6BYwPhB9cCPKuy02sN5dYVo89ZONdj4yFDEfuuHhxDcredc/eOV9z5Vzmv8?=
 =?us-ascii?Q?EXWp4x3qEas0qYMEecAeRn5dqyTVe8eBkaDIFp/cWiDIUMLxTGScH7B+0rFt?=
 =?us-ascii?Q?W4e9XTeRrF8abWwd6INzMv2r/9uxgSAET0np2AVgVZRlB+L7uXEoxkzJwtle?=
 =?us-ascii?Q?Tuyqj6yOcg18ZcfIoK4Z/Sp9JF/Cjmo0TPyy7csG+aWXmeOdAKR5ZVbwFgww?=
 =?us-ascii?Q?KuExyv2eKxhb/TuhRkoWjv9WhhNDuBJBhy+IQYolUkUm2K7qYfxvFvHEJYma?=
 =?us-ascii?Q?t7bcrQVhSo00MfvspCK57qjCwo6HM5g6OKVLBNNz8+qcDtgS1LAsB2yG3/lm?=
 =?us-ascii?Q?k6bgR5DMQgEPm+/DidrhaWmjCs84qRYDdMmIL6m5mMEmmo/o1kazwzA9+Xzs?=
 =?us-ascii?Q?DqywdE/nKvNiIa7JRJYppdPxQjW4WzzQYL6K1xT7tzikQOFsyRYAxIbiQUB/?=
 =?us-ascii?Q?WBQLJYnBI2dKm9cuNIyg3v5sosMMvhaFxtHuB6PZXugO0oCu+k4+djcl+QMw?=
 =?us-ascii?Q?41qnHODxS1J17V73pBhaYYvqhwY6uKJjyG4wKaIKzr1kSsDsnAxFCP/0HWSK?=
 =?us-ascii?Q?fz/LnAiA224ZBkcVXPmu5KYQ9Cnq5gKWXxJR4Ra6wmKWxD/Mo7zluFNoQgf8?=
 =?us-ascii?Q?LSnp9WS8sywWctkJJuGJAneqiUS9jB9s1NYuDh0UWuDuH+dAgzF2TTasqNjs?=
 =?us-ascii?Q?gnsMBOwXvbLvo2AU5tDijxnedzjrmC9KF2BqKb8h5cpSfVelkwu8cKd+lNOA?=
 =?us-ascii?Q?gYTkcHCn0G8AIw6qxYj+NuXh27RJ2JuxkQGWkpZ0VcdQoYVO0plRy/WY/lGt?=
 =?us-ascii?Q?cUFOCaCbRGJDkgSRdONhsNftlYeyVTk3F9n+Xwdi6SrgxmGgUZuNmcnpsW7b?=
 =?us-ascii?Q?sMLjgI8kjCqlc6k2DtUYWauaiHqAkHG6s/j8CcIFh9LuY+avTuZGsWMX+ZeJ?=
 =?us-ascii?Q?R73MQCZVNh+AU7iXwW/Q2BeISIBtN+jWEzFsCbBX/o1wELwtjt//DxJIMajK?=
 =?us-ascii?Q?2I2aP99RYmWQ6QobU4G0Zrhmv6xWXyoSE5i0L7yw++UcX/ULGm/FW2btvLY5?=
 =?us-ascii?Q?HENs3WZTGx6plfPGY7CmVyAS5Ll1SLX9gzip7VDnjSTqLk1tuc6tCtF5SLaD?=
 =?us-ascii?Q?bSY+R3sOF9ZPSTZ+eR2gdE6/UVBtCHi3X1tMyyFBHh2kOM4hmdh93PLt1Yh5?=
 =?us-ascii?Q?EzVUaMY9njHWrRPt8FEZuPsK837RajtEdh9TtYWKbai5SEr95kA4cmA1q8ew?=
 =?us-ascii?Q?2bfnj+0LeiDicQUCs1EIlQ9vh6Q/u7cEK6XnGRcMtD2fRNQrxhTfLHpjaWW7?=
 =?us-ascii?Q?IHwig+yHXQY86eksqiIG1Irg59H69ctHck7NzWAANtn4db0XiQ0B6xwkUDQf?=
 =?us-ascii?Q?IMDrFs97YNEie3mdKJ89OUBri1FjBFBSTe7yxyiDMkQ6GY1qxPCAL3BG0bFI?=
 =?us-ascii?Q?zztvpCGqlnZoMTXTqT2HSbqZw8L2k63OPSC0qVHmmJJWSXHzX8Ca8UfBIpHY?=
 =?us-ascii?Q?VjXcrr/sjMHUQ00vFF28dv9lsG/A4cOtEYCztEVLQ+tOtdISPq+CQMDyb69j?=
 =?us-ascii?Q?JjkBp1YQf4SsdGYvmgLfUeG33wBFSwrKAXsQxe/lf1OHg48VpHB8Sy/55i60?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Co5g/E7zZw0O6AoeGsDcLh5JD84hALWCcmp5VUYU4T1oY6X8DC+Vl4IVXh0LLw08PpirJB0b3h85Jytn7gkUm1KBkTe6o5E18wdpAGXsyttMdKajJ2olfnDXbI0fsKnXzMCvKFXPHPL1Rqd1R07sbFp7+Qyaz9AOnw8WB++C4pMmJ7C4KCiFj38GMYwMhU1Nhv9VlnqTalnArnmJibAv0CUZHs9QsNc8PXn+CE3cY5knD70w+eEJoUnrTjYs/tWtr7nNajVIjVZqqikhpf97cRICEnog3CpuKhPL1JDiNVeOmSMYCwyN9bQPhJEEemvvT18Jbk8lDayaAORu4edxn4IhmMWM0vZBvhngGQe5qT1/mEFQKaJM5iBg2yFE4DsDJbZkkM8v78tphcsXQcdkmhZs7UuefVdytd1MZT/R1fD3tLBynNYgMCfHDsECgjipgHslUP2enzKBaFt67ZQOx3pBxMTWT4MNDyGO13LoUrg1KRB1EoJ9DSXyE9n321Ey4VN8Kt8aEKiU7xk1c7AovP1a7m9uShrJTau8cS67Lb0AU4zbbUOVZM+eZyagD7TsbmDsU5X+sVAn14f9KEPzg/yyHdcAeJIGLzy8N+encFhYGUxNsmcrLxrBZmQN7HFINjc+TpibEjKTK34LUT4jNr6OOhiIzBhGD9mQUZ9uTCrpIE5E8xvftAC5aDjzqGvxVAR/IyMEsK8MGnbbssUBX1RjYs+XwSQEOn7SWzcp2UShfDWAovM4P83x9KRH6EcKPYoz9YVh0H794Wm7BHm4oigFQcRjrj6w0xlHwhKAHn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4fdde6-8f5d-4496-bbad-08dbb604812f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 15:57:46.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsG7yPq/nV0rM/ncJ+C4MeHUBaS+QUhJes/oDTBOstZouYVYphrV0jqnVgx3NPYa41bpFfhnj1JY5ZTFCgUtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_12,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=694 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150142
X-Proofpoint-GUID: bkURgmJJgsBx0td-M1kBqU2yp4UrQQHw
X-Proofpoint-ORIG-GUID: bkURgmJJgsBx0td-M1kBqU2yp4UrQQHw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 13, 2023 at 04:38:19PM -0700, Dai Ngo wrote:
> Currently GETATTR conflict with a write delegation is handled by
> recalling the delegation before replying to the GETATTR.
> 
> This patch series add supports for CB_GETATTR callback to get the latest
> change_info and size information of the file from the client that holds
> the delegation to reply to the GETATTR from the second client.
> 
> v2:
>   . fix kernel test robot report of missing function parameter description
>     of nfsd4_deleg_getattr_conflict()

This series has been applied to nfsd-next for broader testing.
Thank you, Dai!

-- 
Chuck Lever
