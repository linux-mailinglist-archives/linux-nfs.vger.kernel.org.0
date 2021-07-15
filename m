Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EB33CAFBE
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jul 2021 01:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhGOXs0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 19:48:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9886 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229783AbhGOXsZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 19:48:25 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FNfmLa013216;
        Thu, 15 Jul 2021 23:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=oxNLCccpL/tEBe6kwQUqjJzvYyURXXgvk1dtdYWV5kM=;
 b=w8d3cJtbnzOFLFEr6rasu3U8HYeibuQFus2nHV1PxIYd6qqqwiEHv4XIBgLsYY03QVUC
 MgySitoE1yibCfxFTZGI3WR0pmf1M5SLyaDhTS1+6QfdTInWjGrskbWnbAIExbBazHez
 7KBh+Jcjf0yLShxZmn8Mdy6552+NT/jZIERaaXyxN2J+R3HM+NegQXxvJdZBn+09xIgA
 gGJT47oirPJpg4TFzi/ypra0FTbTT6RF/txsImaRmAYzqUb6K6MHsDBS4895axyxBIms
 nljlg2l0dQbaIjfMEGWgaSBkjekXO60PmAaKyQAsuSHPmh5esPsgeuHcdg/ht+e/J3mI 8A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=oxNLCccpL/tEBe6kwQUqjJzvYyURXXgvk1dtdYWV5kM=;
 b=tTgDpD6LEjUkQjSSQ5GaZ6m+gsgPt9MAOith4Lf/tRLekuE03ZjrTBpyPI/FlssSxdmC
 jiSB8VLj5TAZ0WnbbvA0GF6XQtR911T9pgsDzPlIB5gcsAhKSlNIpK6LR4+412PeV5BH
 yo26VXOc3kiCxgqxvhui5XF6xizo9XgN5R9LEXt+4mtviZ9YOCwe+X7XcDW+bSJh+Onw
 MNoE9cmNer7Vzzn1dCVzZleIZZg8yNXa82vRzMPr3s6TCFqNjthAHD/HCNiW9/JzdZI6
 SOeeIsU295ScvPCNP/WcxRepayHZVSrhjEhUiQhQHv2SrgDPHwZ6rjYrLmfTFVd6ZLcb Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39tw3184mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 23:45:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16FNfipq096599;
        Thu, 15 Jul 2021 23:45:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 39twqpd0qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 23:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOgQRxscRez6aoI3U3KijkwYAI1J5SfdhQO31ojo7QXEMWD1CDlnFoN2Pb6bBvHVw2iCahmL45clBnX+UiJUgU0nhVCnOd0orJGQJKQOjnYdVsBqmUokjRrzPyEJV+lrw7Jypzlp9bCb8qaoFQ46P+HeyVXBbs/Xy3B683Y8gWObajKiquqkbWwnzgAhL+DNbNpkaP6LfGh/+viFwAsAqlrwNuHgS8Xz0psOAiteLgklbdeSE7JQnyjKmoK5xh4Mqvv6aybR9Pk8F38bsaHYxUQ5MV2n8mGwVS7KATlt4TnZMxNXaKnmq3ZegcuqmiW3nCBxyPD1Bu1ooYxXN1JrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxNLCccpL/tEBe6kwQUqjJzvYyURXXgvk1dtdYWV5kM=;
 b=gMBFLfaDzsqIdEBuY+ux8NdCEppDYWYceZAWTzKrKQJMPjg2m/LUdFNd2ohEJWcj9q18KL8sNWPx+HKkQk7HhY8XpfWwZ6CX8dtJci99ocRPazLyilG6NRl8ab7qSCvatZQ3eneFMZBu4BL7WVWaJXKohvplP5lkESUHDs0UmU+JMAtT1l3PLpvfD/fdozT+5KtooaBxuxc23NQlVTF/cjMAelzOmujY6O1bKrH3YGstzeqPNlHRaEwYXc+c6nbdJTum7+Ogp10PrMMNKhbvmOUuRRExVw+o1MaocTKRX7zrU+zIuej5LPihqMKWeLuzSNFxDKzi4lSC9WJyokAHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxNLCccpL/tEBe6kwQUqjJzvYyURXXgvk1dtdYWV5kM=;
 b=HHD8w5OLDWbgZe5p8mSjN/cXJFaM0Qqbs963hdN8kN/H9KjwmDOYeeBk676FhihcosVa6ccXH4V6h9o5hKqGlrxWtO4s6+Dvu9DHj4h7gH7nxKOhSXvFhIPcxw8ex98D+RMoY2ypoF8iaBIZzyywscWAmfDDuNRktuPn1iCNNaU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Thu, 15 Jul
 2021 23:45:25 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b5de:87d0:75cb:bb9e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b5de:87d0:75cb:bb9e%5]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 23:45:25 +0000
From:   dai.ngo@oracle.com
To:     Bruce Fields <bfields@fieldses.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Locking issue between NFSv4 and SMB client
Message-ID: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
Date:   Thu, 15 Jul 2021 16:45:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-159-205.vpn.oracle.com (72.219.112.78) by SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 23:45:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd2146d-588b-4cc7-ed14-08d947ea9e66
X-MS-TrafficTypeDiagnostic: BYAPR10MB3047:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3047B40506D2F64F210ABD3687129@BYAPR10MB3047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38JFaxaHf5iCu/nAEu4FWeu0so5sAsQy4DqCG8zLbDjas6jeA7Ojk/lGMc0WsN043ZE08R4IkffNEVvv4X8l9nMV5AgMrEhJmZe76qmfDLn2qfPh8LQcL4nz+4YQCV4193VsaUZ5uStQm7z2k8ElTdUDUiBplMEl8Rmf/NOzLz+VjBH9dWeOzUBPLh9sjBb3ERT2PFSn9L/6wq1ySeWo6AD718Ade4HEfY51+kGTjsF8xm0hfBRR9tvNBI+8ymAE2gs6YX1QZGD+5N/oJWBLpJoeSdmd0yNizWQNwYaddYWZyBt/GWANm7yJkKUHXdCmgIUlVAus+pS5Q1gb2C+0fiCMIg6uV8XpcYoPmjyn3kk3TNtNrVjo1h8Mwg51/rP5xFPlImmdFEz2scgZ94kW1JPjfoXHikGBQ91LJhREPhb+2Vnp7y63OgPpyBKSJ4i8+zPKyPKkj+8Xz5ik+T/N6B4W7xmq8j44gW3jqlpa2X2l6kJw+wZjxWpQb7naBSO5547Ghsmp9W5FpzWLHh0P7RAl/nPQI5BV+V4n6YnG9Y9fWz9KbR3PVroHGqUjy69AxwaGbfdujUS5WI3ovVhDjTbhBS45LzkzDguITuQUy9AftWguOnMcfemwUlkFP6u1KiEbeoPbGk7w2eGuItlQUoW3ac/vjd76BVmo+8f72cwAPYHsxdVaWFQYf8j/BbiSS86BcWkIP2o8/ZzLPihzeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(36756003)(8936002)(8676002)(6486002)(2616005)(31686004)(54906003)(316002)(83380400001)(2906002)(956004)(6916009)(6666004)(9686003)(478600001)(26005)(186003)(5660300002)(66946007)(7696005)(66476007)(86362001)(38100700002)(31696002)(66556008)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5RZm51WExzQlBQcHF5UEJVNEVaNnVJNzdvb3g1elBtUW9ubjlFTmxWQjBE?=
 =?utf-8?B?NmtERDRpYzltb2w5eUNnRzJKR2I4YVkwUGJNeGdoUlVaazFaY0pRbzRIVXNi?=
 =?utf-8?B?bTJzWEFrZEpmZjV6YTN6UVJhYXBCaHIyMHkrZHdVNzkyR0poS0J3VmdpVW5G?=
 =?utf-8?B?eXVhdmlGK3ZHY2hjSlhQS2R2MDVJeVl4U1BjNm5rTkdIZ0hxbnhSMnM5K1J2?=
 =?utf-8?B?TVR5K1ozM1hTcDR0YnBSZFQ2VGR2U1I1SERxanNwVWdHdjNLREFTWk13cVlE?=
 =?utf-8?B?M2pNdGV2by9uaFhlcWlPNkxqanhKSDlOTzFJVEU1QlBVT2JHajJTa0ZDcEEr?=
 =?utf-8?B?aGl1Tlg0SXZrTnBIM3RMRnJZU1RPY0lSRTJkelBDWFNKMy9rUTRJYmg5QWNP?=
 =?utf-8?B?Ni9mNmJWWStQQ2Jlc3JENXBwbEtkTWtoT1dzb1Uyb08zdFczUk1HN2x5eUxB?=
 =?utf-8?B?S3ZRUWFqbEh5ZllFOVBFSGk2SVlZdUlvWVZ2UjlOY2R6TmRYdzdhdjlxVTVx?=
 =?utf-8?B?YkI3eXk0MGVDR2xWL3JvSzZPcXB3SGZWdHJFYmJJSWg4Y1ZiZWhDc3NweS9y?=
 =?utf-8?B?SXowYmQrYVdiVVBPUkNPeW5hcjNtRHB4ZWRZMWNjZGpuVXhGRm9RQTRxWTJ0?=
 =?utf-8?B?YVk3aWRWZDF5d3BmbEViWTYvODRjd0VFREFLWldzajVIVlNlcTJJOERERzY3?=
 =?utf-8?B?WE12WnZtU0drSUlxUzNUK2FEaHNUNlo1eTY0S0tMU01DRExGRnB6UU44RDV0?=
 =?utf-8?B?bjFxMitQSFJCUnF0VmVscm53ZUZzQ0NDd3oxaEpXdC9qdFdpSmRhSVplMEhS?=
 =?utf-8?B?NzdJV2RDVW03MWR2dXFvY3NSblo3TUZWNU5KZitCUUJQWGZVNi9ZaVZXZFpw?=
 =?utf-8?B?R1Zyc3AzVUUwc2dEMG4rR2ViK1ZnQU5mRVVpZnhicjJMSmsvK2pDV1ZxWm5w?=
 =?utf-8?B?dXFIMDhNdEJ1TlNvM3l3YVppOWFRSUFOMldBWW1hSEk0ODhDYnQ5TFJ1V1Zq?=
 =?utf-8?B?VEhJQ2t1L3VsUVBkMlJtYjRRSkJTNVg4RFkwY1p4OXExQTd1SEE4aFl6Nm90?=
 =?utf-8?B?UWhySTh4MXJKQzRxNnhMK1BIUnljWDl6KzNPdzFPK21EMFFzSXVITDZWcHhB?=
 =?utf-8?B?bVc4YkFQbytzdU1HVmRpd3d2U0NCTHorTjdacnZqVlZqTXYvTktNbTdjaUJY?=
 =?utf-8?B?UUhSWTd1RHk3R0kyZ3ozMkpwak5QbjkxbGZnOTBkYXc0L0Z1ZXlFMVJMRm5x?=
 =?utf-8?B?UWRiUzdaK1Z3S3VnbVB1WWtUdVBWZDh1dGdPbzhOZVp4bGdKWi84MEpCTXdY?=
 =?utf-8?B?aGt5KzlESEdROFk5TWpVc3ZqaE1xWFlrcVFRY3RaSnJFbHppS3BjUnFZOUVa?=
 =?utf-8?B?eG0wcFZNL2RmY25odDhYMHQ0RzJSN1IvNCtJakJLL3BsVDNVY1VGQU5Yb0lW?=
 =?utf-8?B?OTl0M2RxcTg2UDVFQkpyNE4xYXlBMnE2QzVtVDQ3a3NMbXhLc2dpYXdiYUl2?=
 =?utf-8?B?ZjBkbUtGTGY3cFc4d0gybEVqaHJMY1pPNXFtczE3bmlHaEtwRGp4N0wzQ2Fi?=
 =?utf-8?B?Um9IWHArOG1ZR3ZXZEV6VWprNFJyNzV2U3cyUmExRWRqQ1pBTXF4YXdhZ2li?=
 =?utf-8?B?OGQ1ZjU4MkFnZHhHVDNVN2dBQkdQRVV1VFFrbjE0RStRalVpYkhnYng4bGI3?=
 =?utf-8?B?Z20vVTZpaWc5VVd5bjlieWRhWVJ0cS9ONndyUkNYVDJXUHUxMkY3eGs1QzdD?=
 =?utf-8?Q?QfdG1LiGYvZe3P2OE87Xchl9UfqEdPssyd/1d5Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd2146d-588b-4cc7-ed14-08d947ea9e66
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 23:45:25.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7CjBsjF9QeYZ4Ul/KeuCX5KTPRFUs7cxf3kFanZLzbdF3yetAlK1Z0FsZx548c1HtzQ4+9cHf8fVcFR/xa1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10046 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107150154
X-Proofpoint-GUID: zUI0akleI8zAwdp_sswEcH-O5giQHA-u
X-Proofpoint-ORIG-GUID: zUI0akleI8zAwdp_sswEcH-O5giQHA-u
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

I'm doing some locking testing between NFSv4 and SMB client and
think there are some issues on the server that allows both clients
to lock the same file at the same time.

Here is what I did:

NOTE: lck is a simple program that use lockf(3) to lock a file from
offset 0 to the length specified by '-l'.

On NFSv4 client
---------------

[root@nfsvmd07 ~]# nfsstat -m
/tmp/mnt from nfsvmf24:/root/smb_share
Flags:	rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,
        proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.80.62.47,
        local_lock=none,addr=10.80.111.94
[root@nfsvmd07 ~]#


[root@nfsvmd07 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
Lck/file: 1, Maxlocks: 10000000
Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing F_LOCK..
LOCKED...

Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop

[NFS client successfully locks the file]

On SMB client
-------------

[root@nfsvme24 ~]# mount |grep cifs
//nfsvmf24/smb_share on /tmp/mnt type cifs (rw,relatime,vers=3.1.1,cache=strict,username=root,uid=0,noforceuid,gid=0,noforcegid,addr=10.80.111.94,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)
[root@nfsvme24 ~]#

[root@nfsvme24 ~]# smbclient -L nfsvmf24
Enter SAMBA\root's password:

	Sharename       Type      Comment
	---------       ----      -------
	print$          Disk      Printer Drivers
	smb_share       Disk      Test Samba Share       <<===== share to mount
	IPC$            IPC       IPC Service (Samba 4.10.16)
	root            Disk      Home Directories
Reconnecting with SMB1 for workgroup listing.

	Server               Comment
	---------            -------

	Workgroup            Master
	---------            -------
[root@nfsvme24 ~]#

[root@nfsvme24 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
Lck/file: 1, Maxlocks: 10000000
Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing F_LOCK..
LOCKED...

Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop

[SMB client successfully locks the file]

The same issue happens when either client locks the file first.
I think this is what has happened:

1. NFSv4 client opens and locks the file first

     . NFSv4 client send OPEN and LOCK to server, server replies
       OK on both requests.

     . SMB client sends create request with Oplock==Lease for
       the same file.

     . server holds off on replying to SMB client's create request,
       recalls delegation from NFSv4 client, waits for NFSv4 client
       to return the delegation then replies success to SMB client's
       create request with lease granted (Oplock==Lease).

       NOTE: I think SMB server should replies the create request
       with Oplock==None to force the SMB client to sends the
       lock request.

     . Once SMB client receives the reply of the create with
       'Oplock==Lease', it assumes it has full control of the file
       therefor it does not need to send the lock request.

     . both NFSv4 and SMB client now think they have locked the file.

pcap:  nfs_lock_smb_lock.pcap

2. SMB client creates the file with 'Oplock==Lease' first

     . SMB sends create request with 'Oplock==Lease' to server,
       server replies OK with 'Oplock==Lease'. SMB client skips
       sending lock request since it assumes it has full control
       of the file with the lease.

     . NFSv4 client sends OPEN to server, server replies OK with
       delagation is none. NFSv4 client sends LOCK request, since
       no lock was created in the kernel for the SMB client, the
       lock was granted to the NFSv4 client.

      NOTE: I think the SMB server should send lease break
      notification to the SMB client, wait for the lease break
      acknowledgment from SMB client before replying to the
      OPEN of the NFSv4 client. This will force the SMB client
      to send the lock request to the server.

     . both NFSv4 and SMB client now think they have locked the file.

Your thought?

Thanks,

-Dai

