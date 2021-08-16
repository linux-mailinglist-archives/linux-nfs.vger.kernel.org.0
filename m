Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3833ED919
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhHPOoU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 10:44:20 -0400
Received: from mail-dm6nam11on2106.outbound.protection.outlook.com ([40.107.223.106]:64480
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229594AbhHPOoT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Aug 2021 10:44:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApfgUvz9RX/s12NpDuR7Jxcm6Lqcv7RpvR/pkUNChJiilDUGHTrib9QQbCTdVHkxnrxvtpO0LeYKO2myIOYYmQQlCehiitreplDZ2f44EC8kpGPK6YUOdwOZq5t2XBzqS3IjmDWpRoo/YqrQBz+1G54WIDjegDxjUvgJPPWjhC2HcbvrXK2+EnXPgy93Co1681lF+tY58Xw8Wqd+8NWzCpPTmRcSr6bQW22eUYqtHs3txCcw4ZfDaKkIAyeXUDAs/rr90LFAb/hinUGzOOZjzw7F5mTjcknDNKoKTxX9xX9K8hl+GIhGF4fAIou61Gp/v66yES4wqItElZEg7m/3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4XS7ce24BvvClu5Pn+qIQQGXpPB1ESFNb7+g6M95O0=;
 b=ZzXRyVcdQ85u7KpRo87PVTaW6eEI+z51ak5wAbhOoaPnkiLak/6N1HjZ6O6kztovlvaGd5ZEbEzEVV14QPbYpECNRpqOQp2JNX0INAv7d2G6nVMBUqnwierJHgGU0FR/OgD1Mcg+Z3oPmUJAM2LF9MorHqyCs2eyGiAHtpNbpQs2GShpBQ9EsFIZ3qKUafEYMAu2DrQ40paRya2pAB9WhysfLL7TCHiy7yVB2UYS3mBZaQ8+1DZd/Buyg//cc59PKnUaRixlXr6IovTm0GC4dlZjPJQ/z6bOudcN+WhFPjeKgbcd7bl4KFaXWE7xnDqbYadSA5bgquYMSBMiQ1696Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4XS7ce24BvvClu5Pn+qIQQGXpPB1ESFNb7+g6M95O0=;
 b=PXPdOQ2tI7TXIDXzUuuvEdN75IUcsek8cd7406UcBP4L4xZ6KPjJ5Y9jtwPA6xXdatppP4FcFd6WkewcNrda7ZWFS749hHtPpYshYTKydtLXeMGaoUrq4aG/LIL5uYVvlUg9FMTnZVauFqrt1NM3fdM4CVItrjMeXXeDgvDKrvo=
Authentication-Results: raptorengineering.com; dkim=none (message not signed)
 header.d=none;raptorengineering.com; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL1PR14MB4838.namprd14.prod.outlook.com (2603:10b6:208:313::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 14:43:46 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 14:43:46 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
From:   hedrick@rutgers.edu
In-Reply-To: <507179738.1235330.1628612575436.JavaMail.zimbra@raptorengineeringinc.com>
Date:   Mon, 16 Aug 2021 10:43:45 -0400
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D572050C-02BB-4210-A928-B44FB244AE52@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com>
 <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu>
 <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu>
 <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
 <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
 <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com>
 <1119B476-171F-4C5A-9DEF-184F211A6A98@rutgers.edu>
 <507179738.1235330.1628612575436.JavaMail.zimbra@raptorengineeringinc.com>
To:     Timothy Pearson <tpearson@raptorengineering.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 14:43:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de369a5b-6b9d-416f-7d9a-08d960c440c0
X-MS-TrafficTypeDiagnostic: BL1PR14MB4838:
X-Microsoft-Antispam-PRVS: <BL1PR14MB4838EB2F67FD5CD50027F0ADAAFD9@BL1PR14MB4838.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoRznW2Ru1AEH+t6SfjoXUIfrNvEJRsny4Vl5twm4AddZ1IlOo6W5Dg3hgPTAakQ32lE7zN+tocIp70XsRQ0S5LqV/qGScK1GxF/+1Z5iyCansQU9tWDRns8SgPwuYEDCl00WrXPZCzkIy9392OwkmYZap4OuRR5uM1usjdlaNESC8l9TCGFBX5tUKQ3wbm04B4qAcMnx5KPaWVruHJEClgrkMASgyvHZfciIR9UUIZyFp5CrP8sGeuhf6Z+8+qnnBPbSoCrvYugIE1UAnepDyXiW5AV0fSjqyWKEGWsJo2KUeDa/siutXAAamxOJVktjYp+Vyv+PhYE4a7OTstwT9NnLSAcpyE6ibMqDhduc92VO0LKm9FQml0/lMDiEK579XnGf6SKQ6je0P9FFsURofZfeRm9UwHfpmejA7PBdLWbwaMav9EQy9qiKYO8HE6cBOUHUNKwq9KcMSjcEKpwz3n4Pti/lxbq2Uyn8soZ78qok6tXs6GijvFNzDtLoIrs8kFrT2ffa/xsrJdHgTGmkQ8oCaNRYPf4hpUn4bbUGuNlekhaKDCcfYQA33bb2n6B3oyV157Zlg3B4zkLWaN+91UmD9rqeTGCF6rZxXWl65AuT5K4WHdZg5kRKF/8gSDj5EqsKuAtVyOXMEnlWj1uPtdMXEQlf4YX41XFpkUxTIViQwghznxkHBupGWMwko+h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(66946007)(2906002)(8936002)(52116002)(83380400001)(66476007)(6506007)(86362001)(54906003)(8676002)(36756003)(38100700002)(478600001)(66556008)(9686003)(6512007)(33656002)(186003)(4326008)(75432002)(6486002)(5660300002)(6916009)(786003)(316002)(2616005)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk13NnFWUHpJdlRYSWNJQXFrTG5MeFBidGd5STNPS1V1NVRpTkNRMjB3U3Nx?=
 =?utf-8?B?NXFkWFc4eDNlVXdKMFpiOURCdmFPTDNaaEIzMFFzdURYMmNzb2VubDkreXM0?=
 =?utf-8?B?ZEk1dms1bGlzMGRnYStESU1ZMC9GaW1xNVZYcFJZM1UwdnhoVDJqK1BINXBv?=
 =?utf-8?B?L1NYeGZqekZ5VkJFZ2poditEdjRkNmR4SDFGUjFxWXFTcjJtOGVvb2pXMUhy?=
 =?utf-8?B?U21QZmpIcEp2K2pwYUJUSzlZdzNwcFNmbjd5cGp6MVZ4VklUMkhTY25UbmlY?=
 =?utf-8?B?d21vU3B1UFdHSzVDNWN0Z2llVklWR0sybWkvL2tuTE5vR1AzeS93d20yTngy?=
 =?utf-8?B?NFhzZ2FuMjhHVHh1WmFQUnArYzdoRlJndFJPNWRUaytaWUdCQVZxRkJwZ0lk?=
 =?utf-8?B?V091aWFMYkt5RisrQ3docFF4NWlBUHl2SWtxK0tkNXBxNUp2R3c5akR4R1dQ?=
 =?utf-8?B?bDZIODdsSWdaQVBQKzM1cXR4c1BSUGkyeUZxanUwRDZ3a2pMMk8vR01EZ0dD?=
 =?utf-8?B?anJBd0d4VXdSa0YrR09UVzhvUitLUkc4T3BuV3AxN1FSaXhwMUFlc2JZUEtU?=
 =?utf-8?B?ejVhQzVXWkpkTHZwSW9JUUprOXFUekZBZ09DODZpTEdpdlAyUTRtUGo3NDRF?=
 =?utf-8?B?UlFmdUlRUEpSaisxZ2RkZzF0VFZpYUNpd2prUlNaNlg5TUxWMWU2UGtZTUZn?=
 =?utf-8?B?dTk4Uk0xTFBHczRQMEExcVZieHpaMU5IS25weENiQjgvMFljcTExM2tRYkhM?=
 =?utf-8?B?OHpTV0FRWlBOSUtKanN3aCt2N0ZSV0hjQTRnZ2x6VWV3ZUJxL1ZzQ0Z1V25I?=
 =?utf-8?B?N0RtQndDc3RPeFlnNmZ1SmpmdTI3VVFreGZXelB6RWRZTU9KY3BnTjJKRXlq?=
 =?utf-8?B?SXBrMitHRVE2NzVpVWg1SzFsR0lYYm9BQmFmNW1qdmhTSXRINk9QMHlPd1c0?=
 =?utf-8?B?ZElneFJWaUNIV3BqTGs2UUZsc1piSXRid1VkT2hTYzZNem5JbFArcWJ3TkUz?=
 =?utf-8?B?d0gwaWVhK04zYXZmWXZsdHFGRmVqNDEvQ3RDR2FuUFRGWjg4cVpCT1Y3M3ph?=
 =?utf-8?B?NHhWVFVDYmFvZFNBaXNEZ3F3NDQ0djlEZmVwWjd4N3B4cDZXRTFGUEE3dXRo?=
 =?utf-8?B?MGNTcWMvRzVzYWNXWVM5cm9IT002YTRFSmowWU5BV0dqbVNWbzk5L21PbzVL?=
 =?utf-8?B?eW5WaTJ6czJ1NkgzaHlUc3oweVYxbDVtWnVBVFVSM0hhTmpDUzVuRE1ZVWlu?=
 =?utf-8?B?ZXZzU0ZtdVBFRlZEWmEwZ2t4TjEybmp4MXFKYjAzbEM4R0EvWW5kc1oxOEtL?=
 =?utf-8?B?SVZCbTFpN3Ewc1ZyenBxY0ZadWpML3B5WVBVd0JlQ09IVWJEMXYrbjNpOEE0?=
 =?utf-8?B?enFkNG5GVnhYTkk1NXlPQlFPc05tMElvb2pEVTV2NWFkN0dmRWRtWGQ0UkpQ?=
 =?utf-8?B?TGJwdVExZUlIQytmZHRUYnZBSnVMdjg2QTNTU01pcmsvcDFHS2NVTXg5U1VU?=
 =?utf-8?B?TDc4dEJMQjFaQ0VRRHdvZUZLbjFnUkJUajBSQ2pzcGlnNm9hTkFKWkQyT2xM?=
 =?utf-8?B?MDY2TTlTU1VuTlU1djE2QWxRRGxCUFYvdm54TGhhSWV6TUVTczdvZ1drWDZY?=
 =?utf-8?B?SVJtUmZkS0pZL0QyK25kcXVuSkxCNmE4WHNDaGJSMHdNK1RMenpibFRUanFT?=
 =?utf-8?B?a1g4Mzdsa2dSNUJxWEpyeUJLL0dCOUxOZFE1cmlEUFFubzhGM1lMOE1lSytJ?=
 =?utf-8?B?ZWFiMmtobmNITXc2cGs4MTlrRTBvaXRDWktnRk1ETm9FNWQ1S1V4OWVLQmVp?=
 =?utf-8?B?M0xpSGc3MFVPaW0zQzdBQT09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: de369a5b-6b9d-416f-7d9a-08d960c440c0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 14:43:46.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAHzc84a8GVQrErpFiclSManJORA1iEaPOD4l/TUIZZDHk27BFqnqPAp+V+ZChYXDcRr8Wi9GMR6V4omzL0QgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR14MB4838
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

FYI, we=E2=80=99re been running for a week now with delegation disabled. I =
think the system is stable, though with intermittent failures it=E2=80=99s =
hard to be sure.

It also seems to have gotten rid of errors that we=E2=80=99ve been seeing a=
ll along, even when the system was stable (which in retrospect is because w=
e were using NFS 4.0 rather than 4.2):

Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.030257] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000fa7d3f1=
2!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.031110] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000fa7d3f1=
2!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.031977] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000fa7d3f1=
2!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.032808] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000fa7d3f1=
2!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.059923] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000b6b6f42=
4!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.060802] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000b6b6f42=
4!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.061671] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000b6b6f42=
4!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.062478] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000b6b6f42=
4!
Aug 10 18:12:17 daytona.rutgers.edu kernel: [634473.068624] NFS: v4 server =
returned a bad sequence-id error on an unconfirmed sequence 00000000b6b6f42=
4!


