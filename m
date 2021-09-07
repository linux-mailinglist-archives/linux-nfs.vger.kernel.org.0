Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B374024DF
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhIGIIu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 04:08:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23458 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231366AbhIGIIt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 04:08:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1876HnL2011548;
        Tue, 7 Sep 2021 08:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=gb6SfPE1HuEnq7TpCdCTj35XumNatOiKmY3AA5t2EfA=;
 b=T+6Hg1QcRTFXJEPyOmcyQBZiERvGE62quCZhrbY3P8vG7+vllKSM7onXqdiVmJXbh06v
 JbBCoNAfc7lqsuxoAIglZ8dAyTYpey07NF2Tqyh2ET1WRUrIgqY9cYlJ8/pACeIj77jH
 D4DjID8AlgEAkJH809KDLXcKsstI5C1RNUv1Wn3svDP8JW+2mGxH0G4y2WneVUBOEDvN
 AliKxHOeVN0XXINwmFc0dOkUs3i9/IbBWr1pOenhn985nCiiRoNm1Huu5PogjUhPrWZ1
 K4gH4OcX1SgHwnmFr5rv4cTs9bUusYI9iOAAYmaAAnQdN8oZ8+6SGPXLdUQsHwqnqFCf LQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=gb6SfPE1HuEnq7TpCdCTj35XumNatOiKmY3AA5t2EfA=;
 b=XPqppQdUfkGmjmNPbQcVXpEMnct7o/YvPJyGs7xwjsOqJ7wbnzkT0zZoyb6Zft6vV4lN
 s9sgadh5YEniygymivBrJQJn++z4HPkZn6xSwhDPJkS1D4aA4uu5ZryrcNSmaYDp+Iwd
 GdxorCNbVgrASLSUzHR94/yCIAhNWWUCmw2S+h62ShA4Ej9QYWkInNEP1zh+A6MFYW9f
 ZkEU9Y/6ahx2PMjeuEpbxL0T55nWwlRqEtqGpx1SEXWwlB2UmQIjD+546jzsmG7zBNF/
 07MAkiKpaoHRzHygX0NLEsQhI501UL6i1xRuzRvkL3XMA4O2R77P7sxBgCnLipEcE3je wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpwks0yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 08:07:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18780l1d017926;
        Tue, 7 Sep 2021 08:07:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3auwwwetyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 08:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCzqUppHzyTY2hyOmXNGfol7911H31l4CQ/V366fGEimUao+CuAXC+mYA7yb7R9QOXlQDi8nZvrmEEiYLv/6PX1mAlHonkHbUh+Mf6Gu+NWh8JqZiaMjmW4ZV3BcSP5MseIKKZ3jHVz9x5RshMqN81gsR7XZf18bajoc+F2fngi5gvHY2mOQxC/ZzKCpQw9PTZ2sbPyOPkk6ShJyn3er8HyHgrj0Ntxdu7DJcW9EBVoz+cfkcI526yLlpTlvIj2ldII9JBFyJxfgAsVdS58O/4iKWP7ItaTNcEW1Bv91EbTFJr9qgWUrWDyycFLZ9yE0IZotkml13G3KTDd9i/Nb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gb6SfPE1HuEnq7TpCdCTj35XumNatOiKmY3AA5t2EfA=;
 b=MYG2dInToRHzHyk4cPR5G6+EwPf3xZWeSr4Mrfyhff85NN538CFaN1cyov2CESQyxuL+Zt6cvPFifDGJvzyNc6GKsrA+SeNH7R6rLpOHAZxLir6Csyd/vMDjRemFr59gecljOAoWdV+nyGgxbp+mR4RZ3eJQJLkcGNSTfOstVXPdLI+SxNSLZ0XtKHP4n5hYNkUd35Ft3ThA8P78TUEYwvineG0hqXibU9AnhD7PjpBW1l66Rg5RiV5LE8UTSfagaDkIxAIBE3Nh5UL4llw5ku9csrcFJwmqYWyvgd2xNv+IIZCOwngBusa64QyjE2E7q7ZqkBejnfleMZRF0X0Uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb6SfPE1HuEnq7TpCdCTj35XumNatOiKmY3AA5t2EfA=;
 b=w7sNHDkltSZCNfRZMXpFi5B+ExeMtzZU4e9yFkcS91VTal9zrVhJlqTzV+ITTtWpfRR+J8i5pFGNUB6o7YTkEMkq+GJ2I6W6iIW4VKqFBVpnV3NVZZAAVP2YPbcrdLrElXQe6HttFvc2E/gML/D7NEFSnZlnJ8Ka1poccDZojPA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1904.namprd10.prod.outlook.com
 (2603:10b6:300:10a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 08:07:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 08:07:39 +0000
Date:   Tue, 7 Sep 2021 11:07:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] nfsd: Protect session creation and client confirm using
 client_lock
Message-ID: <20210907080732.GA20341@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 08:07:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3708e896-9f3e-4cbc-4769-08d971d68f80
X-MS-TrafficTypeDiagnostic: MWHPR10MB1904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB19046815CA23C4514AF8A6B38ED39@MWHPR10MB1904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oydw2KLyMI9ZUu0Hezo0Cz1QVOc6dPX57zLCRamsvIU+nG6IW/WMFNjgtEVOo/GJ2dxq+CJj1NNDWTdy9ueKg29FwQzcYvVjQO/Pu595k5iFjYjFSMIAv57nHPDw6j+KuHSf8OtWI/IFWM+PM608K5CAM7Q+hEmWGyigLNRFsxp8MlzWGkdSnJiuVZLKWXYT9L4b4cpZ3X5rDb08Kqj3S95wd+XnIoFohc4l/g2Ne1zeGraKWN+q0kqiSnjg/aK+5hkDDh3v9J3QMCDOOiLNmHf+hcgjycojhOdzJWTFwQ+4nj2dcN4JBubKTun+JBcoUd4Ktm2TrU/+um2dd874/lLhse3s6PZFywOjzZ7TYmAR5vYkkiCS+y52mPX+Y5e9NFlvDc1l7Nre2jHef/ljO3GOIfuOlPPFWUHmOY0oF7En5YwMJ4gNkKSnQxpAq3MKEW6rVthcGu9L2ZieFSxDMuhY8fCGJu8DLcHZ1iDmBUaUjAIZR7LWORMJRxefj15dNI+ioOsD9266a1s8dV1dID/LosoFXLXJeSWOYCmN3YkKz6x9oFPCmnt+zxRTGTkaJgSBN708R3WzUH/LLbebPQqSGUiReMVBO0auPqmWwdgvBbkoE78Y1th2Ev0ThLHeRWKSnPGVc9T6xDlVqVlFv3rCO1AccMBj2YTipNG4BhnxQT0IrqLlw6gox/njlePlBpOCeDOMQtlP1TM7VN4bIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(38350700002)(186003)(9686003)(52116002)(6496006)(1076003)(6666004)(5660300002)(9576002)(38100700002)(66556008)(66476007)(8936002)(8676002)(44832011)(26005)(66946007)(4326008)(33656002)(86362001)(2906002)(956004)(316002)(478600001)(6916009)(55016002)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1HEuMJPZmbAxF3ntmVO8jUrnquUBmvoSBBMwGpDd68yAkh8CX1Xwgl+YeeO?=
 =?us-ascii?Q?rBft7wj+AaR1zLlTBN+nkixUdv2aykupEwGiBkaofT/5pD8YA6u3aCkFdOBf?=
 =?us-ascii?Q?498z5YCo073vnz/IjFE+V+41m057GhX6ZG1FdcJ9A49uCj6V2BuvSHpQRXrz?=
 =?us-ascii?Q?JOAIYZT7CnLvFrqg+PPBScc6HcpHRZF5YRjyhx5Bw+JuehLxYCLQbFGNh9K7?=
 =?us-ascii?Q?Qj77m62INs+N9jdaTMo9P0cJSOkP6iyJ7vkyL7FnLankBYShMO7EMdsf5MTY?=
 =?us-ascii?Q?VC6lZG5AjSH2tPPwz88hJZB3omFBLquFJCvTdpiClrVc7LZio5dbCa5l8IjF?=
 =?us-ascii?Q?nSSU6eWM66QCRoo2Hg91x0WPoA1p/cZZGb7nJ4LDWuEJ0+3PSlqt5hKycgp7?=
 =?us-ascii?Q?NvdM5YlAqFTuGa1W3tp5NEmCChFOcT4Jqx53toD080Cx8Yig32qQAnjvbUNo?=
 =?us-ascii?Q?tzkc6ZcJ9I9MEmLiWDrviLYSP/3RhcsiwZPGlQcpM6tq1ih08MVuUQY7MwGQ?=
 =?us-ascii?Q?81tbh0H9cL975qtsiMhU6XEmg1Yof/nJHk/C5IkF1YUSrBtzjpBzJlVmwqIZ?=
 =?us-ascii?Q?cFBKdWjXviQJMw1pFebh3QSia7XGvdYTC2eB3qU+kLfysRZxUiatqTbpmF5O?=
 =?us-ascii?Q?8/gNjCeRbQyQ2mhwWB2kLmQPLQxVZvVkgieOXzYRTjil3vxXi6hG8402xWm9?=
 =?us-ascii?Q?JIF09gKABfwkSzptT9sVe9CsjqQjlM8ld71/BU6ybXL561yyLLrR0Xgk04fc?=
 =?us-ascii?Q?OcTt3Lk3KjNHjrspD8lVHjxrLxdyOwMWihMxOlxv0REQU6BrTtoOJJkbdHUG?=
 =?us-ascii?Q?Gu0j05X7L01H+DRDfUOZ5dC8SzfyhmoNKYUjFC3X98M/A1GVvn6H/954HQSn?=
 =?us-ascii?Q?BRoc6VUX6lcFFaWPvJ73g+bj0yy2Cxfe7CbN93Nzm5RJ+tTePyfulVx2YJ7x?=
 =?us-ascii?Q?NQ3oamLYseUsXZEZ5c7GM30Cm0yWGvkEH2lfjJtWJy7xiuZWvXHgbcalzFxe?=
 =?us-ascii?Q?i2kTFwN6PZ6ztApoFr73QW2v4UWxpK0RnCXygpyarG+FXdxUUkQYXYVj2jEL?=
 =?us-ascii?Q?8Yg3LOTKLO9IBd4P9hVFyP8zKtX3iAeV8Da1LNOl9180UDF+A0bYzEeP/a3/?=
 =?us-ascii?Q?QwcSPvtCaDP5Zu+XRDy4ZGBBWKg+rU+bSg8U1JefNSVKTpbhjrfb6z7/altd?=
 =?us-ascii?Q?ysB1KFSbaNriSkv83AOSTpoYM/BT29wgm5ty8M43aazwNwduKpLeG5cnT8Xw?=
 =?us-ascii?Q?31QGzQYtT7sq+q1hkSS+bb4BFNDUvwPfPjWSRPX5XALEZFIeI2wZCzfT/vYl?=
 =?us-ascii?Q?EJDl/KkdWfAEwefLOphobUOk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3708e896-9f3e-4cbc-4769-08d971d68f80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 08:07:39.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTyf6vTB8IUXW8N0J82cQHk56upTGQFfu7rEzCrwkFc/emCqLcxsb7cEM704E8rECaLqZ5X0xfQZmxKp1v7EfTkrJdSIktkp11I9d/3+q4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1904
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070053
X-Proofpoint-GUID: PQkz1MTDMMueLCATnBKSZKR03j3EbAAl
X-Proofpoint-ORIG-GUID: PQkz1MTDMMueLCATnBKSZKR03j3EbAAl
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Jeff Layton,

The patch d20c11d86d8f: "nfsd: Protect session creation and client
confirm using client_lock" from Jul 30, 2014, leads to the following
Smatch static checker warning:

	net/sunrpc/addr.c:178 rpc_parse_scope_id()
	warn: sleeping in atomic context

net/sunrpc/addr.c
    161 static int rpc_parse_scope_id(struct net *net, const char *buf,
    162                               const size_t buflen, const char *delim,
    163                               struct sockaddr_in6 *sin6)
    164 {
    165         char *p;
    166         size_t len;
    167 
    168         if ((buf + buflen) == delim)
    169                 return 1;
    170 
    171         if (*delim != IPV6_SCOPE_DELIMITER)
    172                 return 0;
    173 
    174         if (!(ipv6_addr_type(&sin6->sin6_addr) & IPV6_ADDR_LINKLOCAL))
    175                 return 0;
    176 
    177         len = (buf + buflen) - delim - 1;
--> 178         p = kmemdup_nul(delim + 1, len, GFP_KERNEL);
    179         if (p) {
    180                 u32 scope_id = 0;
    181                 struct net_device *dev;
    182 
    183                 dev = dev_get_by_name(net, p);
    184                 if (dev != NULL) {
    185                         scope_id = dev->ifindex;
    186                         dev_put(dev);
    187                 } else {
    188                         if (kstrtou32(p, 10, &scope_id) != 0) {
    189                                 kfree(p);
    190                                 return 0;
    191                         }
    192                 }
    193 
    194                 kfree(p);
    195 
    196                 sin6->sin6_scope_id = scope_id;
    197                 return 1;
    198         }
    199 
    200         return 0;
    201 }

The call tree is:

nfsd4_setclientid() <- disables preempt
-> gen_callback()
   -> rpc_uaddr2sockaddr()
      -> rpc_pton()
         -> rpc_pton6()
            -> rpc_parse_scope_id()

The commit added a spin_lock to nfsd4_setclientid().

fs/nfsd/nfs4state.c
  4023                          trace_nfsd_clid_verf_mismatch(conf, rqstp,
  4024                                                        &clverifier);
  4025          } else
  4026                  trace_nfsd_clid_fresh(new);
  4027          new->cl_minorversion = 0;
  4028          gen_callback(new, setclid, rqstp);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  4029          add_to_unconfirmed(new);
  4030          setclid->se_clientid.cl_boot = new->cl_clientid.cl_boot;
  4031          setclid->se_clientid.cl_id = new->cl_clientid.cl_id;
  4032          memcpy(setclid->se_confirm.data, new->cl_confirm.data, sizeof(setclid->se_confirm.data));
  4033          new = NULL;
  4034          status = nfs_ok;
  4035  out:
  4036          spin_unlock(&nn->client_lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is the new lock.

  4037          if (new)
  4038                  free_client(new);
  4039          if (unconf) {
  4040                  trace_nfsd_clid_expire_unconf(&unconf->cl_clientid);
  4041                  expire_client(unconf);
  4042          }
  4043          return status;

regards,
dan carpenter
