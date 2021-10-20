Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74CB43440C
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 06:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJTEHx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 00:07:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24512 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhJTEHx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 00:07:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K2H8K3022170;
        Wed, 20 Oct 2021 04:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=wSWpeT8DYG4ERCT05dnCGqMQEaEWDs/8abCL++l7RVA=;
 b=NuFwbv4eJ8b7vY+dAxFvVL7VizQbHyBzE9La2mckbAK86fAVTmKWkRG2SW8Fkqfo6oxO
 1ay5UjCEaaLvCQsYSFGFnPBR8mlGf1V3qf0grBG9ePI79zhy2ez/a9PiYa8WJmbJqfqP
 MkpEjCmLHIXJsiH8qh4rI9wYaeMRlB7qHDFEp7tAHzgBL3I2KgGUOCE42DrbUEwwbDdr
 fKKXz2DfHnEP9J617cZIZGp+9uqA7GUM5YTOFQ9lMpATUvrad0iXCqg9XNxWEVhEK+af
 eAe/IHHAlCpu0A5s5YTMbT9UCMIzODe7R+kKQd50JrfcPp6esWMgx5vyxEgOh4fHjc31 Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsrefejvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 04:05:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K45Xhi055334;
        Wed, 20 Oct 2021 04:05:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3bqkuycdcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 04:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cI+lroBgV/+Xi9yVoJXfG6Jp+iKrL+tumZ8KGOG6u1KMYJZYXbHjgqTv4O2ZSAycFCCXuq+DI0vbSGP7dIPFCAp/uKREKwYFs5/wyT2bmSi1NUUK/daHpq+wz6TjXqWbZOuRkIrRuftLCWEsJPl2kTLrYBwfXhRZ7sCE9KSXRedyksbtqKwVljJ3Bt+4RKzWQ0ySmel5k/r79BA1ozHq94t9jfe6eVcPkAWISRV2wHGTAn46bGZd+PLruFYgnliW8IJZByV0w5VD5trYJ0gjGne3ZAMjcGlpeZBTtZZdEUQD5bjATekTFZtW9bAxa7gI3GDcNvfPS2AReQNx/yYLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSWpeT8DYG4ERCT05dnCGqMQEaEWDs/8abCL++l7RVA=;
 b=jCvGunvlkeGm98bCrZclBoWDTX4BLMppp9TC8ZCy8oftnW9Y8VbJ4ou1f0r40TijmtmiEJFlBp4qFkqN/UCSnNdyF6oKBTex/qmVagO26fiVRVnQmHgdUs55jEZ/dRRRerfq3ex/BAR/nFs+IWl/yLQv+jQasH2J3ebQ2O9z7jNORtIqfHTzsOk8jJ1OUTdnjHmSu8DeSTSpBzjg6eROgwaLukqBESWIu1/rR9Jq5cOyp52Eo89lFSgndUH4wu5G3CLG8tG6m1pZ8eu8X5BCqeHmWPEJdxuC1iqnPYJ4K1s24Z/qo4ABiXd4dFQ9tBGT2gRUdtTFCmqIXP2dYwE4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSWpeT8DYG4ERCT05dnCGqMQEaEWDs/8abCL++l7RVA=;
 b=Wl6j/cLbY2XI/L61pLopVublk+J59/5j0Ywx+KwivBlSGO+m8eZyJAcamKYco3d4DfwOn+IdriYTUW+d+SCMi9b9IW0PXVkSzhrMXkQpv25WKGidOi3zd9tKOMGqMmYM7tjpUKrWNnNaP4Yxh/Pn78eXrZoLBLJKEf85UtqRnzs=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 04:05:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 04:05:26 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: remove QUEUE_FLAG_SCSI_PASSTHROUGH v2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ytsbawr.fsf@ca-mkp.ca.oracle.com>
References: <20211019075418.2332481-1-hch@lst.de>
Date:   Wed, 20 Oct 2021 00:05:24 -0400
In-Reply-To: <20211019075418.2332481-1-hch@lst.de> (Christoph Hellwig's
        message of "Tue, 19 Oct 2021 09:54:11 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:806:120::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.25) by SN7PR04CA0045.namprd04.prod.outlook.com (2603:10b6:806:120::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 04:05:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8598a0b-ffa6-4083-ca55-08d9937ed8a2
X-MS-TrafficTypeDiagnostic: PH0PR10MB4774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4774A546BDBDA0366EEF88D38EBE9@PH0PR10MB4774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyBaL44iN3dJSvFG/kcPM9Fsq9L8ranzjqSa4c2mmV6iZikzSJRC+qeHY9+jzmM+hZsWW9m1iG6kZZodogElkY6rcyo9d9WAj+Acq7/CnFih7vPqPLzfEFqJKUU8xbMGuMX9LybphXQbhfzFHgLZGolC8zFZdep29h12fWKhcNr958a96gpxyKj+hupZqNKBgIB1Zv0wIi035J9szZJsmAuOnfTN0yCRwdJjdH7WnGKhu7SfLxIdtrnHh571hiTEJ86aIAJ13GuoJcjVTIk7lAev0/0vqMOiDx2Sn2G804GWNsdXcfLBr49Zg9c+t7QWcP8XoBn+dSOT3mYUCxGhZa7bEL64uRlqxUpa0+bv4W6N/x1tYFV1RlSoCxcMos7yPhGhrB9CDRw/GnNOd9HqL3UILfiqj+9JpjazVd/T0/4s0sXQIW4hEUGr6kPXhYU3gLAXXhjd1HzX20LAj/DsyAueBq+UTC56KHoV7/XTS4giH4Pws7N/cyxSd744HLhEDYESCLITRDW3aAkcQs/6rn5El/F/VjGh2+5WrUqRr4/7SulNcXA3sIwY6PgxbyPwdzdQyz9uH43dHQQFRbGDtHIH6Yww9lJMK7y2XyZbmftIyazRpBzVUwjfCzQz1Nl4O4PShw72sGXHH4BXMsz73mUcjh4fwurCQnJqNkF9Ttx4dBBbpXOl0NI8aM3cTX4pP3qz7d+1rxwPAUYEZeSXRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(4326008)(52116002)(7696005)(55016002)(508600001)(86362001)(8676002)(4744005)(26005)(36916002)(7116003)(316002)(8936002)(956004)(83380400001)(66946007)(66556008)(186003)(38350700002)(66476007)(38100700002)(2906002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aypi5MewUULNk+CkO2MWMvD1rHppwc+DbsSwFK+PyHRx0tJlAhU+AYwop2SS?=
 =?us-ascii?Q?TQZ08B6SQ6Qzhd9qtcTEqGvNqpRKUVF1iAhINMJ+nwOvk5wfHdjy6SXdT0OK?=
 =?us-ascii?Q?fYi1G1ri/mAFoP05jzU59KmoraaeTs/g8jRw/l4DQiZ2XKT76HHF7SXWrsEs?=
 =?us-ascii?Q?mnoO5KA9rubypp2eQZZxfYg3zrq91cseuFhe9EtNHNrVcJptzpBgrQ7ulSyD?=
 =?us-ascii?Q?P0h9r6hgMlmWrv2HZP2OrEDqPpakqhS8ALFKIOMy/VPpezmxmhSrNAg1Icm8?=
 =?us-ascii?Q?OmIZSY7DDQFNB3PExUJN1u9q91tMbA8viPWD6vV+ChUFW0w68STOQa1QvALi?=
 =?us-ascii?Q?T6M+sjdEV70sgJr2lGqVLIrpckqUXCU+SdgQzgnqYhstV4deo/8qrX0R3Pk5?=
 =?us-ascii?Q?3cxYJJj1fLcnudugfPiotSAuabwvF4q9eTa+GVzGThmitA5tBovq4Nb6J9/P?=
 =?us-ascii?Q?1Y7aqzNFuyJS60O9jMJLg9ZNvZ+R64gU1UIzq48AA6eHiuZ0hRxKiEGLktAc?=
 =?us-ascii?Q?W1aVgdXJL9tzesZfjVrimbIwpwIGvBMYkGiuI9rBxHaW9dPH+CJF0js+fl7s?=
 =?us-ascii?Q?KLZD96ZikzLUzgSPrl0GlZo079ZkUzkMxnczk1xwOVeHLP4QsuKDJBS537ky?=
 =?us-ascii?Q?6Geq0JOA1etLXXL99xuMeelLHuvWUtC29stBsUFEqoi3ertfahb0DJBlHiIl?=
 =?us-ascii?Q?j0P0dLz76tyMxiTxnGYG7TmO3NIo784EwKuOSJ0bIh7dXBvwLJDfN7UJprTu?=
 =?us-ascii?Q?G/BVcZv1/EBqnJUwSAchgeCkcnJ+M6czfc+A2U26PyYeM1sCiq6lbXh1e5t4?=
 =?us-ascii?Q?qexzCOJ2ouA8t2WtyUFegwdPWVnHMXwghTRfqxyuIIsmeAVX26lmslLH6Xjq?=
 =?us-ascii?Q?7GNQfc5nqTSiXcljfln235WB4DP77rnG9MixjUQu6IJcfet5rGl01/66jp5v?=
 =?us-ascii?Q?HExOyBwYET+ukY78QA7vxAahrYL/wR0+epawAx3GDhFQxnubCkacHxNAJ6mt?=
 =?us-ascii?Q?jmtyfYkey8requiw8NgpeFd5uo/bfQY4U1wrh3vRm3WggJ3Kj+tKbl4NYJ5/?=
 =?us-ascii?Q?6e6IK3qzO0p1txTa9grYsz0oEqIwcDC0N0Zu98nX+V0JitXRAqytBOqDAfjt?=
 =?us-ascii?Q?+iK28frWPwKA5NmB9ovNnTMRzhysAki6tSlg5UN8BobHGcBveK/Pac2UdD95?=
 =?us-ascii?Q?tv7vokaqxjTUKkpNnIwH4aU08c5UcZSCsdNsiXnmaisUYpGzJQAzUllMCU5b?=
 =?us-ascii?Q?N5vSW7EdsChRCG0Joqtgc5Ulb5EwOUJz75ecgp74Tw7e1pRhgs7vPxa36h25?=
 =?us-ascii?Q?qVhmTZTF1H59k40PXaQyfPI3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8598a0b-ffa6-4083-ca55-08d9937ed8a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 04:05:26.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: martin.petersen@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=791 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200019
X-Proofpoint-GUID: H7Xo4uh_jriOs7deWboYL-KwnBNm803f
X-Proofpoint-ORIG-GUID: H7Xo4uh_jriOs7deWboYL-KwnBNm803f
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Christoph,

> The changes to support pktcdvd are a bit ugly, but I can't think of
> anything better (except for removing the driver entirely).  If we'd
> want to support packet writing today it would probably live entirely
> inside the sr driver.

Yeah, I agree.

Anyway. No major objections from me. Not sure whether it makes most
sense for this to go through block or scsi?

-- 
Martin K. Petersen	Oracle Linux Engineering
