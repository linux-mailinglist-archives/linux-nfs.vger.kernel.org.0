Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281D7D6F78
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbjJYObT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344928AbjJYObS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 10:31:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F89132;
        Wed, 25 Oct 2023 07:31:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCx4OC032085;
        Wed, 25 Oct 2023 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Yn2tx0I+P7dVvobE6Z+IVPTVQxVx/HVkfUiif5E0OYI=;
 b=Ls7fvoa12FvXBZOXOOqJaPi9RPiX/HfSdf7QIulT95vVM42sp/VAgHXH2H7Inch4SKPg
 l++RsmlA01R8HwwMp+0/1+OCFvsy6Xi0UIbPrYmfyeF2eznFLSUl8t1MhruRhTruTH4B
 JNE34xgDIgyqLqirXUaeMn1Na+8tTCREh28kE5o+wIl6wahZKRVklMshT586246sCsyk
 F99XZIYk6iQIg0uQFB8qWxl63+wQUEW12tkm+fu6tmLgQjM+LpoIqmV9Ky8iGGPiRZBs
 kuMPFDtgPxaJjIe1thbzEuyBWt6orJiosyMpQ/xjfrMOaXEyyorTwNmB9MSjrgvmvNJL Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv76u7wka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 14:30:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PD8Sk5001514;
        Wed, 25 Oct 2023 14:30:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53d7jhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 14:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbzHJUw1GrDr8qRWJ08LH/QIwXzBvWITR0/KAN4vzd3GwwwTkLtAj1TDW/xvWxos7cpIcMwdS57WKlmwuwZIxkEKOLTG0TQcBSz5vu2yBkrzvBgyZBupFuBW+vffg1n6rJMY//PwBIc8ULu8W2pzLG0Bh5mfmlH0SX6WlSQtLxNWkRo2j5xqWhFwAneA9JHDqwjyuX5DOJJENIqiDkUNw6vYOVkWciUkoGSj5Nm2mlQmVexeZ1BXYd8ExTzYtndmRqBb/LUVYARXKnR3uewmaePqOaW7YAEadHn8Qld6oFqgRYKV8GsXb4VHFqBeidDOzNVAHIZI963c1pEpAwzmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn2tx0I+P7dVvobE6Z+IVPTVQxVx/HVkfUiif5E0OYI=;
 b=jpazFT04TlMjTnVGa7tsdljGc7Pv9vQCmLwaLnz3IVft9A+Bgvkdw3DG/3Vk7uKTt8K1+BP4YqowYteSZvHKl1ZCrvTMlUOLm9MIK+7EpSjp1XEUgRrYJkdTt4nN6cBidRJPn5wCld8tdfrsf/WJWxZGM6U2voBnJUuA7NzBrNyPEQLizAHy6f5MeVS0/8VsccKphd4TS8Ua/eXUltfER13AS1eAPpv/A9Z/X6ONP7WtjPygM8WMRiDvHftOsQh4JaXfSeR3xtc2A91ji1h+FaNA2mpEEOlqxraHdKzMiFMpUaMe6T4Mdelly2dV6+0/6fqwBSs0lL/UHw77MDMpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn2tx0I+P7dVvobE6Z+IVPTVQxVx/HVkfUiif5E0OYI=;
 b=K/PonaI/aUddBveInjLJHqhouoYHYlHnIomOLxHSKr+6WUvd7FxKpqf5ZpwUrfvyxOR3TK6ZO7UmSKkZvzpzr22PQ+8BsL/50S/VK+AaeINBrcBgNLqyYlx2NLRESb6KmkjTWhH4gLEHFBQbS7mu8OkjMbHmTSkMgQ9ejDhH7Es=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7751.namprd10.prod.outlook.com (2603:10b6:408:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 14:30:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 14:30:54 +0000
Date:   Wed, 25 Oct 2023 10:30:51 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] net: sunrpc: Fix an off by one in
 rpc_sockaddr2uaddr()
Message-ID: <ZTkmm/clAvIdr+6W@tissot.1015granger.net>
References: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: CH2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:610:54::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: c28555d7-8634-409a-fd4c-08dbd566fecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lK5I71MEuVYpZLzGLgfCiuDotQBC89QOXUAp55dbEhqQ3JS5+fk4OenFIUE5nFDjh5Ni9ujPwdJCd1n6eQy/GglG1C1mdqo4OAPZF7vdl4yrsQEFUryTkpHpJ1IJXiBT4DnZzJPO/gICmtYpLw9XJWR1mPA1hoZBEQcdPOiKgo2l+eg7gPDd9oHbjMQ9BBhINM0BgkUxY73Vun0YIdSmptSIiWmxaX1DyP2q2oj0RK0I1B1Uv6b1ogK158ZxAA8Jpwkugz/WDlXdoREdQYnGdQub/v/5n/tTNVGQ6kwaCavKBIUOVxUvnRHf995LQplCs4zyVDrxMd14NwU7tB69zO9CNzFSNl/NT3mI5vRCzCvbwmfU8FVIAOFsEHHnh+534vfSuaKopUoBByuFq/aC4gevWDXCDUqcZOCa00jyViQUpQ8WAcXqi/C2cooHRXNII0IXEhuz12Yk0+iTims97Q0l941ISFsXzhM6hLLfO8ApLhKRIpKbRlVPGy2vPQvwxltlBgvQWxCjIuKt6NEGuygDGDkQzerisHCiB5tlApnhUj02+zp92gKvfKs9BTS/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6486002)(6506007)(6666004)(44832011)(6512007)(6916009)(9686003)(316002)(5660300002)(66946007)(66476007)(66556008)(83380400001)(7416002)(2906002)(26005)(41300700001)(8676002)(38100700002)(86362001)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?76nAaFCWaV85PmeYu6jvSx7INUkPQv2SiIMrFQSJD2ps3orncn6D7831/R0R?=
 =?us-ascii?Q?oC2qYLcEi+/W11jWmG4lRA/rTlMIra3lai6AzXgrUdRMX3H+oIgbujsbXV71?=
 =?us-ascii?Q?6fXgUkTsRHUD3uo0gG2xrxVbRHz2kgmfmJsqXpi9wogPbhj45c2Ws2yWZJ+r?=
 =?us-ascii?Q?2JFQ2xcYTbYZ246ayhiLDWcXJ5nBgPmJlQ2jzeZm1/aVGkTpxfDlKsfYry6X?=
 =?us-ascii?Q?JMlFcdWVPQnmxkEYVSailEVO5Z1453MyAYKLGG8oj2Z/9C4yFjvzCJD8Xpqf?=
 =?us-ascii?Q?eeRHUgHP4/ovfOfAH4jHM0zunfUBmRRZmm6Ms1ghVlU1e6eq0ZXj+5m6KRhw?=
 =?us-ascii?Q?OwrDDoq44EdC5ado+GQ4UDuIZDJGgrInYeqww2moHBRz2UoZSiv6iS54GPhi?=
 =?us-ascii?Q?ssLWV0bTuvyavJkb62CKf2aK2PEhDxNESDwCHnm5akw1wkGZPFEir+kwYvCZ?=
 =?us-ascii?Q?cRE07yu0Veh7gYmfbs6eRYof5SPMt5uunmvnOIfaXLWVj5M8JJUVY0fXcwF0?=
 =?us-ascii?Q?g7WaH9yg0DCQoBYUHoeKbkYohlLaxzRzqTUZzpJ3R7/cdfKQuXG2L/7+HOLk?=
 =?us-ascii?Q?DqNHzAw88Nic3ptS0y0T0vt0zD+u7Ixi8cK1LXyTKK76/3Aa8Zx5pLLaIfv7?=
 =?us-ascii?Q?dIKoC0eyzeOvmK72UuKNa6fV6ikh+dUNZjMyq9EdCDF2O9t6hqeIBzia9yhV?=
 =?us-ascii?Q?Vsusj/kGf9gjIr+O5E4eKB+1wTKlr5UJm5A+q/5JzLb8zxwVkDHdxLoi/1SV?=
 =?us-ascii?Q?AzBozeVKUbSP6+VKcOQfe7NEYM1+SgqgUX5OiEMx7GLXvJrJ22iZBYj7frld?=
 =?us-ascii?Q?UjpH3HHJTmbenlAYnERIspFxwUGlr7sF9ko0JwmczrgkBlAcBm12dcP5UMOk?=
 =?us-ascii?Q?F/KCNkylCjbtHbio5OqOfhVuFmTgk37jTc/e1JQtHaqPjbTWJBDIyVtZBnoo?=
 =?us-ascii?Q?ngdVRyuaxkYx14dbbnB57tFCDB57nDli69hZq3pAxfp0ntqQ57pFaxjMttWl?=
 =?us-ascii?Q?nUtmmWD3EFbpPoxIC3ed1hyjCPtOQLKnhmP0eL175fmtfB5CkVZb4cwb4/hi?=
 =?us-ascii?Q?szJgejWyGd4uSZZ5lwtAbu61exjyUtZqj3RAHGJGvokeVzpvuHt7ZZahKEjI?=
 =?us-ascii?Q?koSZOwqK5Ya3W1DpNZ0zt5MzIxn2vEgH9AmWDN1+WjeA4VWujU92oge+dxPE?=
 =?us-ascii?Q?lcy6HJ1UJT46Q0+u0QqwMWut6OwAWNc6pQOCWWSoT94JfjIj9LuFZghDcQMR?=
 =?us-ascii?Q?yPC+I02KxIOo/WCsYiyzIkMal7T/QdzTv+MNAAbeNfnPGP6mwGzWJMTGkngF?=
 =?us-ascii?Q?vwTw7/saneTSf5Xidc4Oc3g4bqryx66ILcCG/ohAUsPnvTYwee+lTuq6eUjG?=
 =?us-ascii?Q?BwyEFqkQ6e4mO/8Bhvi/0CuYk1bntT2P1JIFyyCAGkJk0kFymkp1xdxIstL3?=
 =?us-ascii?Q?eMBwmY964etDVEqKCdgnmXf5ocY4ICt9VmnfoGBgYmMJLXOs8UeZH4rKqrV/?=
 =?us-ascii?Q?CZmybDthozxghKZnVF/w8i+vJ245b6HohJgMX1LkHYOvmGbY8FgpaoPsSkNg?=
 =?us-ascii?Q?uF+d9zM1NkK3LFXy41KH1GMVDjg1R97iRyj/ZVJPA86uYKaS9qyEt9aehzOV?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IIlagVyRA9CUjCQUh2WniVDJOMCcR3s0HONlvb0ENcKAl6A+hWGgqHZ7suc/?=
 =?us-ascii?Q?IwdcAhGvzn1m6p+BQeI6/KqP5L6A35GrlHuEf7De0PYbbqGkDakrBlg6Uq+l?=
 =?us-ascii?Q?hhJDozg9BrnTdRP568E8XOTVa4CUYisAyd2tvOmtT4CgQbJiKdCjy5msU0AK?=
 =?us-ascii?Q?qZA3jx9/JLQOz48mgkSDnNkqXH6eeLX1NFrkGO7pASfyKTLBwGl3PApOIMm3?=
 =?us-ascii?Q?htXg5UNHGfDKl2CENyclphoszU2FIpnq+FJFJr4QONrreJ4DKcC9w/UDzTrB?=
 =?us-ascii?Q?3nb1/hvZmzjiWpf2/RstUFWkUd3vOuUfiJCsq6GZ5SxKD/oE9Sbdor/Sm9K9?=
 =?us-ascii?Q?S9d/YFKBxGjpbBtprYXZ/fzxR+hkj7Uep4FoHYYpYcKsuX8dqX5ytdRxI73n?=
 =?us-ascii?Q?5bByLQoIIPVUj8tVQiFNrt2miv5DrrMFyTnsvNxYGpbaKBrskScMXKHBRJLv?=
 =?us-ascii?Q?D4CevaDyNERH708SPZ8fM1G/sPMVtl514Zs3UFIWtE1DftzKf8MaqLdLoIlk?=
 =?us-ascii?Q?e+UJbJu5VMrfgo+3JdxePW2JjiHURPar0wkiIkXaqU0w9fs3m/+1sQOMw1dA?=
 =?us-ascii?Q?HykaJjF222fLq9u5PdqE6O8h1szsFYNdFDR57I0Cxt2g093zONlxr+kPrksE?=
 =?us-ascii?Q?PGEGI3uzPVd/gvIg0qpfg+pjVXbHELoFkD6cKTdvhFIBlNdvcDuBbPC8/DqK?=
 =?us-ascii?Q?LysGq2JJvE8Y3ipWmWZTKajaEcuXECs4JdQUbmSKPw/S/XxFYmi1Fzd2257n?=
 =?us-ascii?Q?O+V+N3drj2YJCv/ksyC5CbbInkM6brikyFNk0z+DMRpEPxs3zsAcFygQgB3V?=
 =?us-ascii?Q?vNX5/G1Wcwm6uEXruZznIwAlPB5tpeTSUDqZdXGFr8esxIRwGP/OfskMRCsn?=
 =?us-ascii?Q?zuPUzOMEQLnmggTLsU6WHpW1zrw6VMxYUGUn6nYP8Lri/8dNwrUag9xBhjHP?=
 =?us-ascii?Q?/lfb3JNF7Fgs8aosks9WZAo+68DZKkiliZMhrZHH9j6zUQHM71q8effRncOi?=
 =?us-ascii?Q?aUUXwYy9zBWJE+vMChhv9YeO2t0KxNacrXPjFFk0rb1LEO8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28555d7-8634-409a-fd4c-08dbd566fecd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:30:54.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4dY81LfqstJK+VuCdqPHlLkeJWCkZ4QapMLfSycIWsOocNCZryJcbs076572mTasjbgOYl5FNTORLQAgkTADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250125
X-Proofpoint-GUID: nBo0DNYS5qmFNff7Qk4mJtaE6HAmsaK7
X-Proofpoint-ORIG-GUID: nBo0DNYS5qmFNff7Qk4mJtaE6HAmsaK7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 24, 2023 at 11:58:20PM +0200, Christophe JAILLET wrote:
> The intent is to check if the strings' are truncated or not. So, >= should
> be used instead of >, because strlcat() and snprintf() return the length of
> the output, excluding the trailing NULL.
> 
> Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Hi Christophe -

Should these two be taken via the NFS client tree or do you intend
to include them in some other tree?


> ---
> v2: Fix cut'n'paste typo in subject
>     Add net in [PATCH...]
> ---
>  net/sunrpc/addr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
> index d435bffc6199..97ff11973c49 100644
> --- a/net/sunrpc/addr.c
> +++ b/net/sunrpc/addr.c
> @@ -284,10 +284,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
>  	}
>  
>  	if (snprintf(portbuf, sizeof(portbuf),
> -		     ".%u.%u", port >> 8, port & 0xff) > (int)sizeof(portbuf))
> +		     ".%u.%u", port >> 8, port & 0xff) >= (int)sizeof(portbuf))
>  		return NULL;
>  
> -	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) > sizeof(addrbuf))
> +	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) >= sizeof(addrbuf))
>  		return NULL;
>  
>  	return kstrdup(addrbuf, gfp_flags);
> -- 
> 2.32.0
> 

-- 
Chuck Lever
