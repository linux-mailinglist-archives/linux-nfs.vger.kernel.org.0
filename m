Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF568A384
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 21:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjBCU0G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 15:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBCU0F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 15:26:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B31CF65
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 12:26:03 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313K4A8l027345;
        Fri, 3 Feb 2023 20:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dnwfmZuxkTI/3s1g94qCrmAPPkwI/qRj2s4TW5wYItM=;
 b=sjWKCWDoxUbdK0V19oaWSkGcBgRBRRPBHZ7P4s2DoprrDOXy5CJY/t5IP8M64+6DpcX6
 tVWK3DBuUsNXAz9aQ9L817jbDoWSxy8cWkiGFFM0UR/i8/p/++cQtlrr23fzZN3MG2iI
 3eKdTpGFOU3R4JKouMqnjKFsDAi5i/CakmTYcv3zEZAnY/TZGy+peycz3v4bouja6zWw
 Y9xu2C4VL99YmmCJ5s7ebXqqhdKuhummhumLSR9iNWu/8+kHGE3vWN6Zvcmadg8Gs8j8
 cYY585UBT0LYpipkZdFDRuSF6zTiEAuzvITzUETKqzAJt5Td4OJpMsTbhNEoyKgQKuHl YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64f2c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 20:25:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313JJZaZ005970;
        Fri, 3 Feb 2023 20:25:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5b2ndp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 20:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj3In+n88X++nnwxAcRxMjsfQWCk6brH6TjUS7+OTxuIXL52nSDnns9UJP1Pf9jBNyGwWNwaYRtYM9jhZJnzrKqgq2hiVecQsl8zZvWrtzZpV+HJfhqrbK0S0M6M+sELkzYsQOb2HgJgPaCBf8mB8Yv622R5y4GrdVCnAKQcwzRGcu+ZH80vXItF+/QvbFVn13+8ORc/F5bz1oNyBEiFh7FFG5ngxiTYgPBPg7vbhgaTYadm7YAffja1c9ILOlS2Ri8fzK1MGPEj+KTFFf1G5PXlc9W1uU0ctkHN8AZ2o9Js609GZwBTf9YEUmYBrAdC/tZ3ffjh1EmOdX5j7u43ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnwfmZuxkTI/3s1g94qCrmAPPkwI/qRj2s4TW5wYItM=;
 b=ahFqSyAmpNJ9Wc49qjoqoBglVjgVBb24V1HSc7gGp3wP5Zu64jynYsn/JyVlqIe/XEzny9kq43o4PBkeRYzGRrZFZgV3MuAhYhDYFft8sAzduLZ0PjIwRXLDOXa2HMUuWWJ2nA48DSZ6y4coZ6MXP8mqx7Or2liat+jTjB+K+lM72nCuVIlDwIU6lJZeUYrG6JKINgJrjMA7ShvgaXgoulu6+nLvtZzyAyLnHNdMAsJhi3Y6bVuKcQRKbgOb9Jh/LQ+JmPoi6PHClhcKycxrbwPaKCf+RmqUbCdnG8jQIdjx9NySDoyR3z4LrTSmASCiiBAkhULnpYFck0LvjDpXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnwfmZuxkTI/3s1g94qCrmAPPkwI/qRj2s4TW5wYItM=;
 b=u9PC9O9ISbB9zma88+RgQXJ7bdsRvoGnSCEv2DNR3zyfPb5SgiFygvKdgnCjLI4dAYyzYgdyfjJC4D0pqIOOsRGwbBinR4S0VTP6rQv+ouIZFj7XnrLXUVsTZogd8UtluVUCxmBCAel2g4cxTNe95pkvMZCclvWTSaqTdOaOEAg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.9; Fri, 3 Feb
 2023 20:25:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6086.007; Fri, 3 Feb 2023
 20:25:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Thread-Topic: git regression failures with v6.2-rc NFS client
Thread-Index: AQHZNbksRLoeBCG00EyL+s5Kt9KD6665E+wAgAEOhICAABzOgIADD6eAgAAJrwCAAAZBgIAAG46AgAANvACAACDsAIAABuGA
Date:   Fri, 3 Feb 2023 20:25:42 +0000
Message-ID: <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
 <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
 <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
 <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
In-Reply-To: <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6733:EE_
x-ms-office365-filtering-correlation-id: 3a28bb7f-dccf-49f1-7c0b-08db0624d2af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1uCHkfd+Fy8tjyTD9L6WQX4yj6i/8i4gd4+L4OVvF51I5xmO8eXX26IaoGZJwXavDlARdexb4q5yhdNz+TEsVu/EbjZvzwoH5Loifemh4zTLOC/3uiR83oGQkVyet0jConHEbah0aWTJx8OEmCphSHKFTlthE8MlsScCsP8YF/hJziHLs4qnvD0sCqV0rt7rUPZhBvfnwLtkDIVOmC+/Uz1pcMaIAld58gkuG+LVd77XohscbHoaXxx29C5zKYf3oWQjpQRb2Yf5xFw5/QTklnwEEG0y+seaWvP1lDmWYEwQDMRFIxDwuk0PHT+IAYFjWZB8/bsUh0kMPqLPJr9ylwOGhTur2rhg3L9NeKKUKhStgcJKHbIcmDLJpBZ69gh5JjKGmqdjUd5o98jPu+b8gSCW1VwY9OrZb3xJ8JE6eZaNLGFT4EHWEeid+QlUHcINf2T+r5fb3+JaG/ni4nYTiPB3N+HExUBTmlIMtEIAr91lzoRYfiSH2C2EiL8qR9C5rSy124mkfdbgWYPzp4g138W1iFkx/V8HozLPtIgoL48oEDK01sl8o3JQ0Q8HW2U9GADnsxJe72PMbr24xMCe9gO0xWy53QK/tjCwbgoTnziW8SgJfB8iQRxl501sOIRDM4ep4Gxcff2s+Pqyscvy9gH/jMSFgQ2zhMzRwnbsZDI/RPjFhQ97glRlJHBo16qZYjzz5vmSm+Nej7JbVDVBLkXRZMmRrHzARo64dlxEhuTESLmtvTcIzg98i/QSjRC7KaEpXAxy631Io+DKjF9STw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(66899018)(2906002)(478600001)(91956017)(36756003)(6486002)(33656002)(6512007)(26005)(186003)(5660300002)(53546011)(2616005)(86362001)(38070700005)(71200400001)(8936002)(966005)(41300700001)(6506007)(66556008)(64756008)(66446008)(66946007)(8676002)(66476007)(83380400001)(6916009)(76116006)(38100700002)(122000001)(4326008)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FUJzTQF0crhfgWqD+oGV+obkP+qYCSKIIQgOtYHXtqCfQhqasC1GfFZrRqIE?=
 =?us-ascii?Q?3ej59sitlG/Zle63O9FlNkhRfo7TDJbGPDys4uYudewRxYuHpYS/835mdeXn?=
 =?us-ascii?Q?3awC569r/KN4GLQr9McWJgffV3AN4mrVLssf7EjVMjzBhUcnqH5OSC8fu8Zu?=
 =?us-ascii?Q?jAPpvX0NG7NOUjdZmBxMfSl2Y1Ls3CTNTh6mq6zr5SUGEhK++qzV3sVT3utb?=
 =?us-ascii?Q?xPZEf/tPP2wyV20dHG+E0sXbwBbB3NMQvnLO+c7VPgF04aEI9Cx7XvQ2hLZI?=
 =?us-ascii?Q?O8M5mw2nnK1g36VMAQgApSbgOmAxjdAf5LfS2gkeLPDrUPY/rxf4+1dKEesB?=
 =?us-ascii?Q?eMkJasZelyIjLThK0o/xGlQ9ChonyI6xE9W3tnrwm78NLJvbzMEdwDQqZbhK?=
 =?us-ascii?Q?FW1Yqcske73si72v8BCkigEZgnOeW5EDG6sLg35uuroCF2L2xUpnT43Gk6Z7?=
 =?us-ascii?Q?K0Pa7B1u8BFU3cJnLNOj5b6N3Qd69ttwYlU18XtkBgqrdKdojdTW/7I1oSS1?=
 =?us-ascii?Q?pNyEmZTUSxmPi0GjQXyFHW4Hlv9ahMuIRuhSK+IO2wqFaHx5rpDvdJF4IVs6?=
 =?us-ascii?Q?pb125iWWV+GXjNx5Vrb9YFsmSBLgBgIKX9Y7SSto0n4Cmt2A98T9v9T1ZC3m?=
 =?us-ascii?Q?D3m/K0eFdVTqSGLINw2PEChVGXDuiDXB0GuALvKVZoFf+FlMBcC97qu3AKfK?=
 =?us-ascii?Q?5t+pscCSp3KfzU+yIuPIExbKzz0UWFCFN9f/8U/IVZc5//Q1+pfbQziFo/tx?=
 =?us-ascii?Q?ERk08E3/oFNAMLPIuNQIUk+uKIERVtu0tADulPCZs6mjQQumeDNakJ//l5qb?=
 =?us-ascii?Q?BjtcO4VHAFg7TfvmmB/Cg3GiUBDLT745yg9s3ivz7qo4PNHMC5j6/oMkFKZd?=
 =?us-ascii?Q?7F4vZ2e/7I7gtTc15vJ7ccgNFKCdq98AZmC3G35JjgtcvDsc4qbxFn+qqszF?=
 =?us-ascii?Q?mZewp8oVNRAZDXOKSDBTLJVtoEDfWJTLxyQz4onG0u+mr3/S7myFGCFZLcI+?=
 =?us-ascii?Q?wLgkg2sZv36bBj8yWEN+1waslkdgt3cvwCIIJTBdv7qZ5X3Tvaf8oCzxKfEf?=
 =?us-ascii?Q?MU4ONTvQU923EH+dsffTyLLl7PWI6fG+GEEoJyLImW04maHXSFdNi/BDmXb3?=
 =?us-ascii?Q?AZN4XUEESR4Z4LyyzB7WMe7myjo2Aul7bluMujO35ypmvPDroeO6dyUqApfg?=
 =?us-ascii?Q?EmGqHmRcKt4SNu8ME0KXNNrH151JCqTjDvsBAYN+4GoHPe9rNIPP4R5t8nLa?=
 =?us-ascii?Q?/Ee63dcKAEwohXbQbWvhZBNLFN7Zam8X4bMbJuIMgNa4NIvAP3s3T3Icze4A?=
 =?us-ascii?Q?Ptn3CcMgJ6Ty+XRtRljj+ThrNVh6Yf2wNm1qXdrTF5YYiqMXoN4FGCRlEzu6?=
 =?us-ascii?Q?iM6Z8OHjKcRNv9+zZvFisu0bl/+L7u2S3a4GOKDUq7HCzKY+DfWMAAh0NyWQ?=
 =?us-ascii?Q?5O40EjBLGYi3COv3q6LGn++bxuoY1WAiopqfP5C/p8IP8k6S2GhPwnceAp41?=
 =?us-ascii?Q?v8D+2jFnvfqiUV8bbBYwcf+2uOaPlrt+GypGkErxvFAt+hWSYc8GKmoQ8Gut?=
 =?us-ascii?Q?jc0zwE5rDsk+MroOUXHRkMC3ZKQVv6wt0z+77wqN9xVg6m29r5aQRV+J35W9?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F45B3665A8B294D871A84BF40290071@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0VgMwpolCoE0y62hJe4qIyKcqCCGlZUegLhmQGwVmq8m8ZnSVFzFGsfL6x4kuQrrjqk5WykTmdUH9pxangr0AH6PYnSw+4J2OV3MzBcdNDuBPO5kZFfOVhwu9djl699PpJMhMqOJVuJfLL1RbjKeIyuP+bQnHKDAI/yXC9VHL+6nEH926VjYcCSczhN6RWJC4Wp7bmmZ5RIi8QEkJCOMfxPjZJ09OZ4wgIklB1M8ueSEEpS50x1NDH2wpTgV1nbt6s1dlLEuEpGIhPDdp4+MAaI5cBdfUZ47xd9uFBONiMMIDzEo/0tBv86tY5R9mjj9CEPXgo7gHCie8t2F1zYSW7usGzONtqMV3qJdM1A1X4Aw8/7PAdpBEQ3BLijFfE3lDEnRkj9lByiy6Ceayv9VrkmJJjo487eBjOOvBf4n5efV5C27wkikvEZ4rPK4RhPGrZZUQgVt2Cs9Hc0RfpCdW2vlUKjxJfB/vYnb1odIq6DnKb3OBzDUVxJx7l1bgY+xu+VUIXhBeAMlsaxu2+NUoPc4fLtUxrR2wYqrmpL31s92+Tb1xt6dKMHXIoYo+RRYGVK5OLXCo6folZ9GYQf0021XF0siCftMu6n/tCgj2yrfO+zbTy+gE15XXHme7B28RW7o+AyFYpXC9Hb0i4zlXksOriKFcf91Ko8Zwu0YIG9CYKxKBcjN9eNVEGX/lp3/YPyTby7Al+VEgyeiNzSMWu2pIefEmpbFhsZ1Br4ZM3/yQF341xKfC+2h3ORiWaFr+Ri+lTUJR2SVbqyDijy2jpkOM7wmuAd65fYmbA/lyNHulo5FSIYcLYQ45xce8NCEMYb3C1PZVJad5tLu2b9bo/SKvqjgttXHmhBrqIrrpLN4xffZjhYc058//c20D8VDx/JILLAt/fQSYTDW8brr6bQP3tBpBHb6mh0wfvDw608=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a28bb7f-dccf-49f1-7c0b-08db0624d2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 20:25:42.6205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMA0bQy8nOT/c0mFExU8HGmcJBI4mKmcodS24+ba1X7ctd7j0b1+yUoNdxXeIH946kbWRpQdzlXmtneN1mpmEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_19,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030183
X-Proofpoint-ORIG-GUID: 1pBhJYW2P-3gvEGIwGC9DpR61ICajwLK
X-Proofpoint-GUID: 1pBhJYW2P-3gvEGIwGC9DpR61ICajwLK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 3, 2023, at 3:01 PM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> On 3 Feb 2023, at 13:03, Chuck Lever III wrote:
>> Naive suggestion: Would another option be to add server
>> support for the directory verifier?
>=20
> I don't think it would resolve this bug, because what can the client do t=
o
> find its place in the directory stream after getting NFS4ERR_NOT_SAME?
>=20
> Directory verifiers might help another class of bugs, where a linear walk
> through the directory produces duplicate entries.. but I think it only he=
lps
> some of those cases.
>=20
> Knfsd /could/ use the directory verifier to keep a reference to an opened
> directory.  Perhaps knfsd's open file cache can be used.  Then, as long a=
s
> we're doing a linear walk through the directory, the local directory's
> file->private cursor would continue to be valid to produce consistent lin=
ear
> results even if the dentries are removed in between calls to READDIR.
>=20
> .. but that's not how the verifier is supposed to be used - rather it's
> supposed to signal when the client's cookies are invalid, which, for tmpf=
s,
> would be anytime any changes are made to the directory.

Right. Change the verifier whenever a directory is modified.

(Make it an export -> callback per filesystem type).

>> Well, let's not argue semantics. The optimization exposes
>> this (previously known) bug to a wider set of workloads.
>=20
> Ok, yes.
>=20
>> Please, open some bugs that document it. Otherwise this stuff
>> will never get addressed. Can't fix what we don't know about.
>>=20
>> I'm not claiming tmpfs is perfect. But the optimization seems
>> to make things worse for more workloads. That's always been a
>> textbook definition of regression, and a non-starter for
>> upstream.
>=20
> I guess I can - my impression has been there's no interest in fixing tmpf=
s
> for use over NFS..  after my last round of work on it I resolved to tell =
any
> customers that asked for it to do:
>=20
> [root@fedora ~]# modprobe brd rd_size=3D1048576 rd_nr=3D1
> [root@fedora ~]# mkfs.xfs /dev/ram0
>=20
> .. instead.  Though, I think that tmpfs is going to have better performan=
ce.
>=20
>>> I spent a great deal of time making points about it and arguing that th=
e
>>> client should try to work around them, and ultimately was told exactly =
this:
>>> https://lore.kernel.org/linux-nfs/a9411640329ed06dd7306bbdbdf251097c5e3=
411.camel@hammerspace.com/
>>=20
>> Ah, well "client should work around them" is going to be a
>> losing argument every time.
>=20
> Yeah, I agree with that, though at the time I naively thought the issues
> could be solved by better validation of changing directories.
>=20
> So.. I guess I lost?  I wasn't aware of the stable cookie issues fully
> until Trond pointed them out and I compared tmpfs and xfs.  At that point=
, I
> saw there's not really much of a path forward for tmpfs, unless we want t=
o
> work pretty hard at it.  But why?  Any production server wanting performa=
nce
> and stability on an NFS export isn't going to use tmpfs on knfsd.  There =
are
> good memory-speed alternatives.

Just curious, what are they? I have xfs on a pair of NVMe
add-in cards, and it's quite fast. But that's an expensive
replacement for tmpfs.

My point is, until now, I had thought that tmpfs was a fully
supported filesystem type for NFS export. What I'm hearing
is that some people don't agree, and worse, it's not been
documented anywhere.

If we're not going to support tmpfs enough to fix these
significant problems, then it should be made unexportable,
and that deprecation needs to be properly documented.


>>> The optimization you'd like to revert fixes a performance regression on
>>> workloads across exports of all filesystems.  This is a fix we've had m=
any
>>> folks asking for repeatedly.
>>=20
>> Does the community agree that tmpfs has never been a first-tier
>> filesystem for exporting? That's news to me. I don't recall us
>> deprecating support for tmpfs.
>=20
> I'm definitely not telling folks to use it as exported from knfsd.  I'm
> instead telling them, "Directory listings are going to be unstable, you'l=
l
> see problems." That includes any filesystems with file_operations of
> simple_dir_operations.

> That said, the whole opendir, getdents, unlink, getdents pattern is maybe
> fine for a test that can assume it has exclusive rights (writes?) to a
> directory, but also probably insane for anything else that wants to relia=
bly
> remove the thing, and we'll find that's why `rm -rf` still works.  It doe=
s
> opendir, getdents, getdents, getdents, unlink, unlink, unlink, .. rmdir.
> This more closely corresponds to POSIX stating:
>=20
>    If a file is removed from or added to the directory after the most rec=
ent
>    call to opendir() or rewinddir(), whether a subsequent call to readdir=
()
>    returns an entry for that file is unspecified.
>=20
>=20
>> If an optimization broke ext4, xfs, or btrfs, it would be
>> reverted until the situation was properly addressed. I don't
>> see why the situation is different for tmpfs just because it
>> has more bugs.
>=20
> Maybe it isn't?  We've yet to hear from any authoritative sources on this=
.

>>> I hope the maintainers decide not to revert
>>> it, and that we can also find a way to make readdir work reliably on tm=
pfs.
>>=20
>> IMO the guidelines go the other way: readdir on tmpfs needs to
>> be addressed first. Reverting is a last resort, but I don't see
>> a fix coming before v6.2. Am I wrong?
>=20
> Is your opinion wrong?  :)  IMO, yes, because this is just another round =
of
> "we don't fix the client for broken server behaviors".

In general, we don't fix broken servers on the client, true.

In this case, though, this is a regression. A client change
broke workloads that were working in v6.1.

I feel that makes this different than "we're not changing
the client to work around a server bug."


> If we're going to
> disagree, know that its entirely amicable from my side.  :)
>=20
>> What I fear will happen is that the optimization will go in, and
>> then nobody will address (or even document) the tmpfs problem,
>> making it unusable. That would be unfortunate and wrong.
>>=20
>> Please look at tmpfs and see how difficult it will be to address
>> the cookie problem properly.
>=20
> I think tmpfs doesn't have any requirement to report consistent offsets i=
n
> between calls to close(dir) and open(dir)

It has that requirement if we want to continue to make it
exportable by NFS.


> - so if you re-open the directory
> a second time and seek to some position, you're not going to be able to
> connect some earlier part of the stream to what you see now.
>=20
> So, I don't think its a tmpfs problem - its a bit of a combination of iss=
ues
> that contrive to make READDIR results inconsistent on NFS.  The best plac=
e
> to improve things might be to have knfsd try to keep the directory open i=
n
> between calls to READDIR for filesystems of simple_dir_operations.
>=20
> Really, the root of the problem is that there's no stateful way to walk a
> directory that's changing, especially if you're expecting things to be th=
e
> same in between close() and open().  XFS and ext4 do a pretty good job of
> making that problem disappear by hashing out their dentries across a very
> large range, but without some previous state or versioning, it seems a ha=
rd
> problem to solve.

Adding the tmpfs folks for an opinion. The issue is that
removing directory entries from a tmpfs directory while
directory scanning is in process results in undefined
behavior because tmpfs permits directory offsets to
change between closedir and opendir.

NFS does not have an explicit opendir or closedir operation.

--
Chuck Lever



