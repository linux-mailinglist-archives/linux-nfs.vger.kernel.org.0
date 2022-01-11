Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3B48A899
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 08:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348561AbiAKHn1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 02:43:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62222 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348563AbiAKHnY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 02:43:24 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TLr8027060;
        Tue, 11 Jan 2022 07:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sp3xLJZGVn5gQy9gQzjnoI9OTYMjZ2sjV7pa7BH/Y+o=;
 b=suxXlTFQ8zXp1Ob8AHfjGOZe0HVRXfHwBKHW0ovZQ7lqKPY6G3OZOyackAswXIjLAz1U
 KOG0/wQuqq+h20t+3INyUiOe36v94259ukK5xBZPiFUgGFbcVZojqrv+2xgi+lijsbJh
 k8WASxbJMFRLd7z4VQJWMfVxGgodW/vluq+7x92p9UhOnebMm+CwnXzykRDy+0kCi1j1
 fQkN5jpQMEMFqn8jAL05f7vqjX6WXs+elj9cbwbKDlCMe/v58KoGGWXIKrbLM74OCOk1
 fCdfSJEeYgk9Po0XkWr2DWIrSosQ89y0yxQ4D6AmEnLcbu5tUE+7mURI/rhwaUx/pimW ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74a8eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:43:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B7fwoE112660;
        Tue, 11 Jan 2022 07:43:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3020.oracle.com with ESMTP id 3df2e4e2w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9ZqrnVmoRDA4DeHnOOg7vqkb5ZCUE3IB2su8WlU06HqdIC7Amjo2ZAEb+jAhRC3qR/cjWWX28vY5vFIFvdKQIJLzYfNxd9k5roflc4S4p0d7VNSJZeU2Z/RfylJn5A6HcPIhD+XCDBLxtuU2mfwlVc6aAqCT7V+ouJetP48R+1OtrUttmivt3anqxVytFe+dOZ6FddR28jhuxIlLANfsrHTs2vOeVlF1hJ9O2ayBNtGaXolZrMQVYx4AFDLatxSCeNYA9d5ZVVDVPS4Y9eehyaFgF5Wi0DDsyDrpuEWPNiZF7QHBBB5UuNhb6FB7KmqZZVhnUfgzDD4jSoefSHmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp3xLJZGVn5gQy9gQzjnoI9OTYMjZ2sjV7pa7BH/Y+o=;
 b=Uf2CrGiElEWErBy0SObdB32/CX8jrKvppwJTD2Fn/s3vE2lTEqDD47IPVsoFpDDS+BCnPD/rmmfgxu5N8XiKNYcXbUI0Dz+CgUxVXb4+9OtLJbWqPZVIgSKrchs8inYqiSY5LdiTczvl0WdJuGfzKLkyMpEV94vllj/csDfSWU6fi0qp3meXSiW9Kkh3WhbcEMmQQWpDRAPvuC+KW7SQbjIya9BXiQaw3z0lKhCbEZSBh9ps6DOIN0LlWW9YaoAXeimDOFlFnOTAGl60ctcW/VCMnp0ikW9HRR+Bu6RJ0XqS+wJ66e6bT9M9QWeImXcubq7M0bzf9B6ey+E/3jjDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp3xLJZGVn5gQy9gQzjnoI9OTYMjZ2sjV7pa7BH/Y+o=;
 b=FkIqHgMhd+TrNbxvLbgMaPBXwpmnuFY54Ri0g3QTLp+bvvRDD87zn8J1FusdAerAl06QTa+W4mCzH1rOUkDz+ja1mYhx20zNUkhBZqCGbWUpND0kr+tJQHngTD7UmK4YXx0k9OG5w7Lsj9EKRB6pEChVUxDO8HyQxRGovba3PGg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1950.namprd10.prod.outlook.com
 (2603:10b6:300:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:43:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:43:19 +0000
Date:   Tue, 11 Jan 2022 10:43:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     richard.sharpe@primarydata.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFS: Support statx_get and statx_set ioctls
Message-ID: <20220111074309.GA12918@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0129.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a8e3dad-1d46-440d-10d6-08d9d4d60937
X-MS-TrafficTypeDiagnostic: MWHPR10MB1950:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB19503D4AB282A0301C59E1BE8E519@MWHPR10MB1950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPhDkX4w2CsTNNyM6YPV91MPYuQ4sKDcUku2p9z8uKFGQLUV8MDzkaWeWn0qh/xURj7Xih7DffBBdlD1ybGiJM3XFutt8a0Oj+M6IXmaJ3JDx6cDso5bjsMTd1flGvRekb8dNZ7E4BTThparwCRGp7UL+9hS/axaHTUOLXkLmHUSXoMOL7TrAV5gA3ZUh+GPGhuJZ6OWv7KopcRXrjvI9KxGsZEEg0hrzGOVG2gnCXC06AgSwPgamIygVm9h1qqZ/Kyojh/YW5qZlXvHV9mLd9E4lRGqra8uXpkrK9K+CpHNCw2GMnBh9i1wVKiV7rpwm6522sxbLWB6Fut5kVnkIL4ubDLRogkfqYrH585HN9Y8MnV6Qw2Ncf04bA/vEmwPCs44YypGZh0PNy/O8BPqJpDLXjoufpa9SQI1dBZe20zwUmcw0rDNtBH3IWjEzzlJ/PddHcp9XDNeQDzgIfAh99YjRqTSO6AxRV1BOx7waedvh51UsOf7j33VljgsU6HwPhNuoHc0YPkosUMOMSO3p9fA/+47QCUDB8UmpYfCQYJk11HLk9jOZTg+zRr9Uy1d8vL6LC2z/ZzXm7yIfhXGy+H+hxEvp8fh5yDhcKcMC6uGWD+lvSWht+ZuGVLAC1OLgyJX7UhmdO/Oo0iZR/2mLfKb6byEPyaVOGJGpO87boBhQOkZU5NsvrTwdqsS/hunkub7QtaKEgXt5haTdK5Lzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(33716001)(38100700002)(8936002)(316002)(8676002)(38350700002)(5660300002)(186003)(4744005)(6916009)(44832011)(66556008)(1076003)(52116002)(66946007)(66476007)(26005)(6506007)(4326008)(508600001)(6666004)(6486002)(6512007)(9686003)(2906002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K7HuYodgQBZRnYE9qnjEhjBsvIQjookkMWW/Yqj9aAncy+Cu0ME6pFcbSE8R?=
 =?us-ascii?Q?pmD/6D8UeMJadV9ukuFKXxmqD6vOEplse4p6dXAK4PgDLRq7RKYeHhwC+Vvu?=
 =?us-ascii?Q?S/pdY2BtjzW7AeQF0VfbTauJc5wbcS7j0Y4FFTR2tLU1Lvllvuu3P1UaskOE?=
 =?us-ascii?Q?VcZdRtE+5tm5WVA1eq+D/45wd9y0gB9DSJ5KRnvh3J7s8HL1mF8TOvqItAwN?=
 =?us-ascii?Q?W01hafDr+JlUilFOHh8kPU3wJarfu+ZJtB0o6smTiImqy0RieIKkl5qvKn+h?=
 =?us-ascii?Q?pyX4RvkvlzvjfKWswLME5ZFusp67OQftn3XSAVE2woWt/XvoqgP/R4rlmdN2?=
 =?us-ascii?Q?JEDkip7viMWiOFnNXio+F6XVy0FqqFqRvDHvhQs6UyA/0COi3iEPSaVLNtI+?=
 =?us-ascii?Q?QxihqpU4aP7I+L4t3NyDWT9jLOFqmqBJATdI01WUG+cRMi2eDElqUALkchXF?=
 =?us-ascii?Q?kHBqG+4BMEnnsDB09rhNaiXP+H9i2HIqAWc4njbkY6K99m4G1Fg+g7JOuJJl?=
 =?us-ascii?Q?KZZMtoDBJQqAy58NbBHKr+E7a0VTjs5fgk6U0PY9vseDVCg2J4UEQXb3aU49?=
 =?us-ascii?Q?hF84HgwiltNW15fDFrqzflWi9+ZoQ9bn1M46nZj7EcfVOiuc0L9ylACXGRKB?=
 =?us-ascii?Q?JjhhPqBTXl5gBGuxdpeqJLIFQiEnr4vkYHLVgXunNBVyEAPQUzVUy8Xj6pqO?=
 =?us-ascii?Q?CEXiJiNbx8fn9HL+CbpR265qpi9hN5SdWCle36AFjvCFZuyWGHxyhjkvEWcc?=
 =?us-ascii?Q?l+bO1OQWU/vcFITyY2IaWqSkWwhB0y6iIbaGp2oMzPAGJ+NSInaVoDx83oSs?=
 =?us-ascii?Q?b63I4mv9sD4lCdcBuS8oUADaLmPwZHWqB3ErouUp2PSROay9tgTo3ze55S+K?=
 =?us-ascii?Q?u7LwCosyeVWN2DpLmF4SAJGSXzuNRsdSU1De3QporeeV+sNn/oGoMkeqjsUf?=
 =?us-ascii?Q?WwnojPCIngX/Z+ueX4PjtophW+I7YKirvCcmftaYtCcusGqWucVMVItNODS1?=
 =?us-ascii?Q?Hv6nDiL/r4RFdtFkdsu827abbeIamVaGfSwH1hkJc5hWxIDox/iCxZVm4G6H?=
 =?us-ascii?Q?SWaIiQYKk8+vUZuOD2AffH0YW2i9ys1rMK0aySZQ40dNaGvKD7xA/6ZHdTCB?=
 =?us-ascii?Q?+40iiYESLEK8/mB54WJrGKSXdztI8odyiZc3FhF53UYKZ/O0yoa03zWyr08Y?=
 =?us-ascii?Q?/djde8r2EcKnG9n1n7BUGbgNiPath+woOriOf+Zur03hJAvqWiV4zcQPVVOS?=
 =?us-ascii?Q?oozlC7+uw78XZQjTxZMQtx/x5KAKLYzVzNw+SYIv6j3g6+4ybCeORxBSoo48?=
 =?us-ascii?Q?9MCnW53X4UVONSU/4rxBfrC3bwwsK99fbTB75zNqJsaM5x/wAGXe6dO76m8R?=
 =?us-ascii?Q?TIGUv8VZ+b5DvGMtJqrgc126tOVTP4lNzwNjTltkBTxrBwczjNZk2oJhbviJ?=
 =?us-ascii?Q?QWQh/OoZTkinBLMQFtVLRFXZZTRFHao8Z+x8oQsfx5mzqIlOKX5edIuQFuF4?=
 =?us-ascii?Q?i2Xd9EYuXdyFBUddhaFQ8mbi50TzO467NqXsrfR0Vl3TmWofko6W/ZFWna3V?=
 =?us-ascii?Q?ZbPPOcvACeW5M/VIHto7kTezcISoo2wYGZAzA5r5GbTT1La6CJZX5YhbBhw4?=
 =?us-ascii?Q?naZXYTszK2khfn745Cs8Knx3gARTiUuYxw0Y1UMcbcSXUjPEgugBGd7+rmsE?=
 =?us-ascii?Q?tzQOVd//b1OEyS8kfDN5r2w82Kc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8e3dad-1d46-440d-10d6-08d9d4d60937
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:43:19.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82Q6jQ8IWVVfwX5+pCh8KsGpU3f/sxsElA1k5gSXBqEx7dYjlcshtN5VMTXZG+YRVAMFcEeDIQInywa01XJS7/n0FDeiWW9YSFfSIJBNT08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=898 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110041
X-Proofpoint-ORIG-GUID: f7QW55WYm_0oFcg7kB2FZdDABbzQuAXN
X-Proofpoint-GUID: f7QW55WYm_0oFcg7kB2FZdDABbzQuAXN
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Richard Sharpe,

This is a semi-automatic email about new static checker warnings.

The patch bc66f6805766: "NFS: Support statx_get and statx_set ioctls" 
from Dec 27, 2021, leads to the following Smatch complaint:

    fs/nfs/nfs4proc.c:8035 _nfs4_set_nfs4_statx()
    error: we previously assumed 'statx' could be null (see line 8026)

fs/nfs/nfs4proc.c
  8025	
  8026		if (statx && (statx->fa_valid[0] & NFS_FA_VALID_SIZE)) {
                    ^^^^^
The patch adds checks for NULL

  8027			sattr.ia_valid |= ATTR_SIZE;
  8028			sattr.ia_size = statx->fa_size;
  8029		}
  8030	
  8031		nfs4_stateid_copy(&arg.stateid, &zero_stateid);
  8032	
  8033		status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
  8034		if (!status) {
  8035			if (statx->fa_valid[0] & statx_win) {
                            ^^^^^
and unchecked dereferences

  8036				struct nfs_inode *nfsi = NFS_I(inode);
  8037	

regards,
dan carpenter
