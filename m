Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73B7E8C39
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Nov 2023 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjKKS5y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Nov 2023 13:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKS5x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Nov 2023 13:57:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B218131;
        Sat, 11 Nov 2023 10:57:50 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABItQqD012271;
        Sat, 11 Nov 2023 18:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=BPuS93fGOuH0wbX1c60N748xwqShoZSwgikOjBhmGYA=;
 b=FczCE5KolLS83uFoiWsmAJ57/wN4A+gyv1r0fjuut9lakzyq7HTXN3qCkswDHkiRVsva
 j5PrzddAWZ7tbU7QjcKL+W4wWW+LJ4AUKnNdgjwcXyy5mxQvx9oIFq3b1GfwWco9TAwj
 1i7as/nnTQyBp3005fbzjSg2dqETzxXCArqp6gmv4kLESBqSMWnN7nE1d+OhPRpvIInN
 gA2yHB8zaELRGixfw6QjqqEZ6OsdQk2whxv7T2bf/SAxqZkmY9vIvclp++9Dl5NxJfyQ
 qmuZXI05ybUuzS3HF+LHd0SoZbEkmxX93wXejv7C/9dwPOx56zaokYR1LtUHQwDUwR3I XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n38jww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Nov 2023 18:57:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABG0CQm031199;
        Sat, 11 Nov 2023 18:57:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ua023awy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Nov 2023 18:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9thQsPkrhtAdrGZwsfXo7D/j7w5SScyFD6XQrpD1GFKfgMPgvmG3vJEGxq3PVoZEAu9rcu4ztEyQihw150IOwVl0fZtUQZ2bIwwbHJz5rGU5zl9F6SOg87Fni8k9eIe/AkA0BS9MRMNpEBy1ornKlhEkVWa7hHel/tybWB6W1pKwbDp2/qVUbmWv6S8bjF5CWGGnGbYZhhWgyuGY/CNPJCssF5xok+UIs3WWlO7Gmpv9zPMsTzyTTNOFC+beP3iqKplPEkM02FAx7dUOhPTgNkSHVqP5oSKH1MC8o9malaMQnglnJ1TJm2WI0dQGqiq4/mKnSNavisplWjTPs0YZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPuS93fGOuH0wbX1c60N748xwqShoZSwgikOjBhmGYA=;
 b=KGoTrhNctuuvRZfFUL0jzCsAj9EZNQqmvicRT/04lL2Du+euhbF0v+V+j4GOyc+Rye4MFtSC/W3/fYxLurJJL+3cjpyNrseaHKA+iM0M3xmoVOyHU6uzugS/fFe3qn6zN5d9JdCf9P+CU2OGriwJgjUL7GGHuXPAf3egO7YiISvjDg6u9lltMit+nkOG96VF57DOSmNhkoHF29kNeqEkzndV2yZUBRkYy/eP/5LJwVYZE435zgBk7q8SYqwT886nEpJ7eEWrZsg8O+0vPpfaCmM4o/TpG/Df+2ndoz3ZGd5/encrrzpKb+ftzsYFCrnPjRu+p6NttIrKqmLIVzSN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPuS93fGOuH0wbX1c60N748xwqShoZSwgikOjBhmGYA=;
 b=m9DReTxNpP9qtqRmTWXlxT82WBwfdBw6hCxVnYtq4IMtMeTUFdYcfAWPza92tSf50Z/sdy+V54c2jmGPjwG70DZQ/AaUh2ceEhpaEeQZ0xNBqILaxuYTE5q+8cbigCToJX1i2qZAqN3X/Hh42ekwcYSiEzBJmS1OBwNOwlxkg2k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5286.namprd10.prod.outlook.com (2603:10b6:408:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sat, 11 Nov
 2023 18:57:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.026; Sat, 11 Nov 2023
 18:57:37 +0000
Date:   Sat, 11 Nov 2023 13:57:34 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        neilb@suse.de, netdev@vger.kernel.org, jlayton@kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v4 1/3] NFSD: convert write_threads to netlink command
Message-ID: <ZU/OntVC2qEwrsQd@tissot.1015granger.net>
References: <cover.1699095665.git.lorenzo@kernel.org>
 <ac01a0f3972dd8175238e27a69db0acf0fed89db.1699095665.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac01a0f3972dd8175238e27a69db0acf0fed89db.1699095665.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 414b6ec6-8ad9-43ac-f0ee-08dbe2e81258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+YFQ9ACgI6PdzkHlTzKiM/orOazsVV0F0M7x1ggYrS7NcvxoRDBALRx8VtWanGhHQHUNU8lrAsrMKYxqkg9Rz1NNVkz1qdflJv86ncsFjEfdxSaS9cxAFnXCzhAM/w3YBLetQBELCOwn/9LNPj5OW+gUQofUaBW5G2vQmJJYkgC4jBu1cQtIL6EJwIt7ieulbntSZGnv4Udq4c44D2XZApnCa5sCCGcHJyM1oIyg31lI+BMZV3v55mMjr7GIFKHFdystlj/ptZ43DGO/jGo2GwHBZUf8hx82sRHCs+Bv1CjkTiKj/rO3n2BYJFa5s6unTJNvfDidO/nLP/VgIw+vundcrSGBCjwhtW1V4KfYAwVgZEO9Pqve0TCgDWH5hBVFJ/bu6sHxfDcwr608Rg5jK1SUai8e/mXjnX66RgC7+9ymiZzjbMweNCOpkhYsU2CjkHyHynSdEkefIQ6bSGX38Fkwq7gSsw3G0QNiC/q834ilqcWMYJ8bWwdLAJsR83yIylTF8GLo3O4UHuykZm2Hu7jAVdyucSYImPlvixnGwomewkWI8CpLeHhCgzgu6RB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(30864003)(83380400001)(38100700002)(86362001)(8676002)(8936002)(4326008)(6666004)(6486002)(478600001)(44832011)(6506007)(41300700001)(316002)(66556008)(66946007)(66476007)(6916009)(5660300002)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwwg8OQNQ2zed2rZvd/HglEf5uwrx1ohhMQML7lMSPpyZ6rSaRKEZ9JjSw3b?=
 =?us-ascii?Q?dFjWp3yBY9JfUcoahORyjiKCuys36LEh/lD0TLLZ5r4k9qUU0N7dDx6X9Xwt?=
 =?us-ascii?Q?Av7mWOSsZxJe4RWuPi702o38zzqIytJOSgsmyB8RfcrcA5pfVZD0R+p1WrjA?=
 =?us-ascii?Q?9ySIacuT39jsZpw/YgWZdC/rnDgYh0r/H9nH7GIpKdgL0h4e1Z2KuMDGthZF?=
 =?us-ascii?Q?USX+rLnzsN/Q6QqkzuyasP78RTYmN1MCeH2S62GPOoYkNyfEhssf6qWJ/2lP?=
 =?us-ascii?Q?+SxbXbuYY/qhoklepHwRaJWrrVU9kMex4fqQUa9+PU5K8s8jT5KjmYPH7Q4C?=
 =?us-ascii?Q?vqssRSEWo96PfRQfYFy6Rcsied3qx7f2QA67jxYwsqx5Qy42hOwU31qYi0Pv?=
 =?us-ascii?Q?EJiK0LWyVq5JJez7Zhz41kgU6xJXvECzBaotfkJOR4vSUO7CmSW+ZGqNlS3T?=
 =?us-ascii?Q?f1aNAkCIIdoY0wF+wjRvfjlsi4Grcfh1Yt0HvUQvEeo4gaFlhSq4cagm1HHz?=
 =?us-ascii?Q?ZPl5aoC1Pw353i61DLJNyqT80GeDOKSneUPjJ4/8W9n89xVqrNneSyacJZ/S?=
 =?us-ascii?Q?q1j3sf30KFKgEm0sVyI5pHkcTehnAAMTq4UlswRfjQ7uutkMyb5SCzsbByiT?=
 =?us-ascii?Q?N7hy5AzWZo5f8UNGglt/ud1gpeHonr9l7RSmRkOWk6X6uhvMf8uNrW3H1cJz?=
 =?us-ascii?Q?Uf/ql4/MtI8RBjwWi3OmxgFOOd1PPdLRBYuMg9KAmI+mB6L2A/L7a55DRgYw?=
 =?us-ascii?Q?OxUEZCxiFAaHxijFE5XH9dWgyrpO+XWXhtJOC+p2MkwzTyQE0xUDSl+ljC5c?=
 =?us-ascii?Q?z6gt4rMFN8q6rBgyz9MmKTHXu4LWEl/RbJDTNUZ6LHC+V3tJQnkhyEXM2xCs?=
 =?us-ascii?Q?wf5mSfp4RXOthEH/yJQWFFzfRFFjB29cfKbxyhdVdxx1ByK9TP8S7x9Zq4/d?=
 =?us-ascii?Q?5gaeEc4GVxRyWnnyChOwIqF9bpyG7dIbV/wGxB7C++nqlIRcOPcXY7LnmW4k?=
 =?us-ascii?Q?B1MHHXCCyjsrpWU8CLvndIe6Vej4SeMO3JAbR7h2SHU3Gl+jxpYkz+VmB8Zj?=
 =?us-ascii?Q?B8qN1iwCwVT8Bt5VqML+jhAYX9ofe94P9KYoUq/C2EJWpiflmlZAw+Uwz8VP?=
 =?us-ascii?Q?DYIXNBCY9XbkjWv0RNPO5EQInaSFLME1WQEiN3i9t/kY/eBpFzCWDuDrneGx?=
 =?us-ascii?Q?xq79YIeZ0/g39YcZX1xr1prQ4DsB7rKELXbqiO/E1bsHW2MXvdPXCvRkfLjA?=
 =?us-ascii?Q?Gmw2taBVKtDytjboxliPkyMdKgsbim20hD88t4TJPajckpEVIWv0mRRP+3Z5?=
 =?us-ascii?Q?x49n9D8IeAAVS8igAfcWD7n3dYBvp73MGOO64/7L/3BAWpM4/PAuD4yY371f?=
 =?us-ascii?Q?RAy3dl2SW2sUpS67zp/1heiGPDwuOMcpltdBlBcDyFX2GsHc1iAl1b3RtdVo?=
 =?us-ascii?Q?aucieofF1rvUpRXK3PcmC0zqd7DdozCUM+5CKHcKzzEIuS+zJqhXkAPL0pmS?=
 =?us-ascii?Q?BC/mXqwCVjcgA9ysZ8JnhWvatuVll915qA28FAPMXskSjOUWF+Pl81BQtjn7?=
 =?us-ascii?Q?89MpnPKrhMNqtBezC/JGmb8FNLgjSLYvohfhdlYQtGKt0tMjgpeeib19pNdJ?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JgYY+FkRx3LVoNJhEnarUHLQQGH6fMuD8uDDPHei4U1PzSPrysASFaoihukE5MLfD4JkgUul9Adrh2Ctz3dESOGKz/h4/R4WDdiIW7q052xTf0djREsV9g/nTbv8zxi0ee3ja7GhgRKP0uD2ObHOi4RXmqyptHxVXVpR4cIkUP6cjWhKH1rx50n2EmpJZQ2jannhhsvoADV7d5nVMylv2g3qLoSGLw6WBjDYcut0KmP47PMXmk3Wv/nmfYskp4glrjVhdybt0B6JsmlLNcSlyyvuYPPCHThWVjrv0X5+tr3znuMzIvqX7xX3j55VU94R32VAlJEK8L4V/qP1KqUkVMtPMuRGcQYNk4a0cREXoBaxbigduxz8dLztrmsoRnSe+aePDGS9fBvow6G+yYbh5kpc1Bm9achajpw9LxrO8rBY9Uq/FGSbWuk0b6cSybdqo2C0mmb1h5V/2f7OVD5acV47IWJrA4+H1TfdWyfvYYBM+kj25SiJ96AdKJzXDI7C2USBJgAomCZK710++ze8p+80sztdmMTTAoIE+bMCmG//almxI/G/6c8pvFBWvi6fZz6cJKa+Oh4qTNuc9dqdlR7dydPWVivhDiq+Mr4Yn5kW1nqoolJ2+sRAQRmjJ0yNFf2DTA3srep2ylT9xSKkS/nMDKS3Z8Q4p/j77TGf7IVvF9L5QMBWoHzzAo3+LqXuLgUkB0vN2fySE2JwG8uo2k2JNr0KGm6hb5GgYCfhKUjkE8o12AxBdq9ApwtWg7eritEwKUunVy6h7Xx7lGgEG0SB5fT8zAZneixq4WWYpUWl96wDHM81vlkM+ArYvl3KWNrZInULxZ0l8GOaKr1oRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414b6ec6-8ad9-43ac-f0ee-08dbe2e81258
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 18:57:37.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Og7gAYjsNV/YSs4fnDNbnL4g8ZfZ5LT+pPlztlSNi5tmU90ix2fPCXAn19+RfKtRE+gz5FzUs+cmpNYAbl1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311110163
X-Proofpoint-GUID: 8hjp-nAHLGy_cLt9yOB9_j4K1lrRELDZ
X-Proofpoint-ORIG-GUID: 8hjp-nAHLGy_cLt9yOB9_j4K1lrRELDZ
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

On Sat, Nov 04, 2023 at 12:13:45PM +0100, Lorenzo Bianconi wrote:
> Introduce write_threads netlink command similar to the ones available
> through the procfs.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml | 23 +++++++
>  fs/nfsd/netlink.c                     | 17 +++++
>  fs/nfsd/netlink.h                     |  2 +
>  fs/nfsd/nfsctl.c                      | 58 +++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  9 +++
>  tools/net/ynl/generated/nfsd-user.c   | 92 +++++++++++++++++++++++++++
>  tools/net/ynl/generated/nfsd-user.h   | 47 ++++++++++++++
>  7 files changed, 248 insertions(+)

Hi Lorenzo -

This doesn't apply to my private nfsd-next branch. I don't believe
that's your fault... We've got some things in flight here that
conflict with what is in net-next.

Jakub tells me there is some ynl churn coming in v6.7-rc1 that
might resolve the conflicts.

I plan to rebase my private nfsd-next on v6.7-rc1 and push the first
set of patches on Monday or Tuesday. Please rebase this series on
top of that, regen the ynl code, and then send a v5. I will then
apply that to nfsd-next for more testing and review.


> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index 05acc73e2e33..c92e1425d316 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -62,6 +62,12 @@ attribute-sets:
>          name: compound-ops
>          type: u32
>          multi-attr: true
> +  -
> +    name: server-worker
> +    attributes:
> +      -
> +        name: threads
> +        type: u32
>  
>  operations:
>    list:
> @@ -87,3 +93,20 @@ operations:
>              - sport
>              - dport
>              - compound-ops
> +    -
> +      name: threads-set
> +      doc: set the number of running threads
> +      attribute-set: server-worker
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - threads
> +    -
> +      name: threads-get
> +      doc: get the number of running threads
> +      attribute-set: server-worker
> +      do:
> +        reply:
> +          attributes:
> +            - threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 0e1d635ec5f9..1a59a8e6c7e2 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,6 +10,11 @@
>  
>  #include <uapi/linux/nfsd_netlink.h>
>  
> +/* NFSD_CMD_THREADS_SET - do */
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_THREADS + 1] = {
> +	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] = {
>  	{
> @@ -19,6 +24,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.done	= nfsd_nl_rpc_status_get_done,
>  		.flags	= GENL_CMD_CAP_DUMP,
>  	},
> +	{
> +		.cmd		= NFSD_CMD_THREADS_SET,
> +		.doit		= nfsd_nl_threads_set_doit,
> +		.policy		= nfsd_threads_set_nl_policy,
> +		.maxattr	= NFSD_A_SERVER_WORKER_THREADS,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	= NFSD_CMD_THREADS_GET,
> +		.doit	= nfsd_nl_threads_get_doit,
> +		.flags	= GENL_CMD_CAP_DO,
> +	},
>  };
>  
>  struct genl_family nfsd_nl_family __ro_after_init = {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index d83dd6bdee92..4137fac477e4 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
>  
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
>  
>  extern struct genl_family nfsd_nl_family;
>  
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 739ed5bf71cd..0d0394887506 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1693,6 +1693,64 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
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
> +	u32 nthreads;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
> +		return -EINVAL;
> +
> +	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
> +	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> +
> +	return ret == nthreads ? 0 : ret;
> +}
> +
> +/**
> + * nfsd_nl_threads_get_doit - get the number of running threads
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	void *hdr;
> +	int err;
> +
> +	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(skb, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_free_msg;
> +	}
> +
> +	if (nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
> +			nfsd_nrthreads(genl_info_net(info)))) {
> +		err = -EINVAL;
> +		goto err_free_msg;
> +	}
> +
> +	genlmsg_end(skb, hdr);
> +
> +	return genlmsg_reply(skb, info);
> +
> +err_free_msg:
> +	nlmsg_free(skb);
> +	return err;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
> index c8ae72466ee6..99f7855852a1 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -29,8 +29,17 @@ enum {
>  	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
>  };
>  
> +enum {
> +	NFSD_A_SERVER_WORKER_THREADS = 1,
> +
> +	__NFSD_A_SERVER_WORKER_MAX,
> +	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET = 1,
> +	NFSD_CMD_THREADS_SET,
> +	NFSD_CMD_THREADS_GET,
>  
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
> index fec6828680ce..342a00b0474a 100644
> --- a/tools/net/ynl/generated/nfsd-user.c
> +++ b/tools/net/ynl/generated/nfsd-user.c
> @@ -15,6 +15,8 @@
>  /* Enums */
>  static const char * const nfsd_op_strmap[] = {
>  	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
> +	[NFSD_CMD_THREADS_SET] = "threads-set",
> +	[NFSD_CMD_THREADS_GET] = "threads-get",
>  };
>  
>  const char *nfsd_op_str(int op)
> @@ -47,6 +49,15 @@ struct ynl_policy_nest nfsd_rpc_status_nest = {
>  	.table = nfsd_rpc_status_policy,
>  };
>  
> +struct ynl_policy_attr nfsd_server_worker_policy[NFSD_A_SERVER_WORKER_MAX + 1] = {
> +	[NFSD_A_SERVER_WORKER_THREADS] = { .name = "threads", .type = YNL_PT_U32, },
> +};
> +
> +struct ynl_policy_nest nfsd_server_worker_nest = {
> +	.max_attr = NFSD_A_SERVER_WORKER_MAX,
> +	.table = nfsd_server_worker_policy,
> +};
> +
>  /* Common nested types */
>  /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
>  /* NFSD_CMD_RPC_STATUS_GET - dump */
> @@ -90,6 +101,87 @@ struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys)
>  	return NULL;
>  }
>  
> +/* ============== NFSD_CMD_THREADS_SET ============== */
> +/* NFSD_CMD_THREADS_SET - do */
> +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req)
> +{
> +	free(req);
> +}
> +
> +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *req)
> +{
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_SET, 1);
> +	ys->req_policy = &nfsd_server_worker_nest;
> +
> +	if (req->_present.threads)
> +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_WORKER_THREADS, req->threads);
> +
> +	err = ynl_exec(ys, nlh, NULL);
> +	if (err < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/* ============== NFSD_CMD_THREADS_GET ============== */
> +/* NFSD_CMD_THREADS_GET - do */
> +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp)
> +{
> +	free(rsp);
> +}
> +
> +int nfsd_threads_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> +{
> +	struct ynl_parse_arg *yarg = data;
> +	struct nfsd_threads_get_rsp *dst;
> +	const struct nlattr *attr;
> +
> +	dst = yarg->data;
> +
> +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +		unsigned int type = mnl_attr_get_type(attr);
> +
> +		if (type == NFSD_A_SERVER_WORKER_THREADS) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.threads = 1;
> +			dst->threads = mnl_attr_get_u32(attr);
> +		}
> +	}
> +
> +	return MNL_CB_OK;
> +}
> +
> +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
> +{
> +	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> +	struct nfsd_threads_get_rsp *rsp;
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_GET, 1);
> +	ys->req_policy = &nfsd_server_worker_nest;
> +	yrs.yarg.rsp_policy = &nfsd_server_worker_nest;
> +
> +	rsp = calloc(1, sizeof(*rsp));
> +	yrs.yarg.data = rsp;
> +	yrs.cb = nfsd_threads_get_rsp_parse;
> +	yrs.rsp_cmd = NFSD_CMD_THREADS_GET;
> +
> +	err = ynl_exec(ys, nlh, &yrs);
> +	if (err < 0)
> +		goto err_free;
> +
> +	return rsp;
> +
> +err_free:
> +	nfsd_threads_get_rsp_free(rsp);
> +	return NULL;
> +}
> +
>  const struct ynl_family ynl_nfsd_family =  {
>  	.name		= "nfsd",
>  };
> diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
> index b6b69501031a..4c11119217f1 100644
> --- a/tools/net/ynl/generated/nfsd-user.h
> +++ b/tools/net/ynl/generated/nfsd-user.h
> @@ -30,4 +30,51 @@ void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp);
>  
>  struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys);
>  
> +/* ============== NFSD_CMD_THREADS_SET ============== */
> +/* NFSD_CMD_THREADS_SET - do */
> +struct nfsd_threads_set_req {
> +	struct {
> +		__u32 threads:1;
> +	} _present;
> +
> +	__u32 threads;
> +};
> +
> +static inline struct nfsd_threads_set_req *nfsd_threads_set_req_alloc(void)
> +{
> +	return calloc(1, sizeof(struct nfsd_threads_set_req));
> +}
> +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req);
> +
> +static inline void
> +nfsd_threads_set_req_set_threads(struct nfsd_threads_set_req *req,
> +				 __u32 threads)
> +{
> +	req->_present.threads = 1;
> +	req->threads = threads;
> +}
> +
> +/*
> + * set the number of running threads
> + */
> +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *req);
> +
> +/* ============== NFSD_CMD_THREADS_GET ============== */
> +/* NFSD_CMD_THREADS_GET - do */
> +
> +struct nfsd_threads_get_rsp {
> +	struct {
> +		__u32 threads:1;
> +	} _present;
> +
> +	__u32 threads;
> +};
> +
> +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
> +
> +/*
> + * get the number of running threads
> + */
> +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> +
>  #endif /* _LINUX_NFSD_GEN_H */
> -- 
> 2.41.0
> 

-- 
Chuck Lever
