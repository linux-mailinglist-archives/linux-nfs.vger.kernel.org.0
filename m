Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FED7E04C4
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 15:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjKCOeh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjKCOeg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 10:34:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C29CA
        for <linux-nfs@vger.kernel.org>; Fri,  3 Nov 2023 07:34:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3DYqJH029315;
        Fri, 3 Nov 2023 14:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8BacsUmBENNB/b5+3u/pTVQTZotc3uNSArB0YFhomx8=;
 b=FX4nv8/xCeuUkiMlNCJkrUhVXrco55OqZhmaq7H6zKebMtsBxDafGr/u/7fwA4Uvnzo0
 Ozry2CjKelGbzQOC12dsv0TthSp46PbUcSXWB5pRHfuAPYJo3zJ121VntdQVcdVkl6ya
 GWDRGQ9I17cVuJ3O1lgIjgjz6qCR9nzWa6ZFhQ4PfSewSBDz/eyelYvrNnycykNiA6iY
 nJhuH2wRaYo1/fbavgFqTWs0tjoXWFT0bstJaJYhwCfbNjbGX/8cLMF7YDAFtA52PZxD
 FkeMQwthmYGZupVpQCRkYm43MP/Wqo6fNWsSBUVyNnqLXpnUPXEcE7SfFDeJKUt8VSnS FQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtv7ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 14:34:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3CsawW001037;
        Fri, 3 Nov 2023 14:34:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrag16w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 14:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVcHQi3G9bUNIEy/58lMg1XKAOz4lTeHCf+MEKNsgTcGVuu7Yiv+gDHvh9aEagq/FYoPgiMmC+EBLclkdIbdu/dOwSDutrVfImfT3TSkaYVocpa6olaal3AF7wJylejpyF5wCnVXHINtjdLIa8uoq5/FH+BSn7iU1y5eA9r/ZvyUHcJCe1dkHePeur4dwfl8H8MscL1XVFAO2d5oD31jRaDIVz9tKPfiEyQ8oyX7pfQ/TWgVQpt1bJWa3Jz60dKm9sqiy9an4YPWkZ6SJSq50hubv6xzlTScueWSQG3y4wA5TZTTGLGbHgr0U+SnCju+l3qEXHwaGkrDw6C5je5W2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BacsUmBENNB/b5+3u/pTVQTZotc3uNSArB0YFhomx8=;
 b=VTrXx9GceezRYoqde52dR1OHoaafGQS2wJKE0NqKSIc65fJo+0Yo40DIWr1ei2eE/W7yMxRarFUQGrS3J08zbZGNYa/3bGiwic4OvVjDwxeAgseoXA/nKv2ATwa66oDTmSgP4D52xH2t7AkFGC00o9+iD5WrAenh6QL9RLaz/fvqy8At9JqJOkwzsU6YOcmVeXWgqZH8w7D2ZDpYZE43KDQDUM+p0XHwlGmQ9fwKvLt293CY6b2Dj1JWb8mVTYm+h2vzWmfV9Y1qJyfhZRDFQ5Vrw4uDztOm8b2TILYzzZy2eNQrK3MzcvOlkIbFE6MVfbJufDvEUH7ipSHgVZVKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BacsUmBENNB/b5+3u/pTVQTZotc3uNSArB0YFhomx8=;
 b=A4/Mq/7DYwIzaXwrAVqmiyAq7ETS+tXEsRiShWcDTpTFyICQzUdPWiR8s2RTzZp+jbfU7cejmKfftvkh2WTLspqH0l4qPxMgfu6v6V76BlOSoveSEXMLUBULMVr+wOKUcmDHfMdJs8W5kAX66pJf54kSCdRWgFpURbdGUcJb0Ro=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6870.namprd10.prod.outlook.com (2603:10b6:8:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:34:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 14:34:07 +0000
Date:   Fri, 3 Nov 2023 10:34:03 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
Message-ID: <ZUUE2z4tnvGbVKPR@tissot.1015granger.net>
References: <20231101010049.27315-1-neilb@suse.de>
 <20231101010049.27315-2-neilb@suse.de>
 <171568f8371932f66429b4557bce7aaf959215ec.camel@kernel.org>
 <169895539002.24305.2542985743958570903@noble.neil.brown.name>
 <83c7ff4f3166c5780ce803e43eaa65e9d9e2f6bb.camel@kernel.org>
 <E792C97F-BB0F-46DD-828F-113F95270464@oracle.com>
 <169897368475.24305.2294425791696451143@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169897368475.24305.2294425791696451143@noble.neil.brown.name>
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2c514a-7ef9-40a2-eb95-08dbdc79efc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jgce+j8M99/KgTfhFP69ezPaoDBz7EOyvtw2iMvTRZS5gc0Jz0hl2X4Q3ej3KrkTd2R2yT8KYZqBs9AZQFU3icn6YPm7x0XwSwk+JXvTHzb/XvpH7nYRrSK61awQUbP+1kDSqI8KaPKm1XsqaFnrUk5AInB25lGhxdDV1v65G4zCfQxI6o6Br/Aeb0AcQT8BAsZw1/xhxoqtJzvfxJbSG1vDXLr3pdI+O0AQY9JF69yteLVYNfQXZ7Ofnu12Ac75nXMzfNTFY6NAHxf5v6SxT4HZ+PVbHsIG+9cBOOdjFnClfRpamN4pFn6zn3adm9B3j3gXM6jlZoCFbJ9JOPgwX0GakQoYpxAYCrTNX+YQbBBBzVwPHNHtB8xsWgHUrO6YHyt8OGPYo2bKmRz/OwhZu1Om+PHRhf2tkVnsn4hGyiqTHivx9fXC4JKoSuxWEyZ20lzzZlz1EM380b0MBFoqKjSDypVG2ev1LRHKk/nAcooC1IvvRQTNEx9jClSdvShqqDY+XiZqqYgc++7pNUi4cIK/o6b8o8OIOgJKEwE1tpH2S60OC71Tubi0nvoP7vPOFxa6cFWtZuO4/UcTN/ScFNihSk8EJpWhcgoOPF/Cxwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(9686003)(6512007)(66899024)(5660300002)(26005)(6486002)(44832011)(8676002)(316002)(2906002)(86362001)(30864003)(4326008)(8936002)(41300700001)(66476007)(6916009)(54906003)(66556008)(66946007)(6666004)(53546011)(6506007)(478600001)(38100700002)(83380400001)(21314003)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgU4D+vMKiCDSvkezK99Cjc9vUi9xEfo2CtTHZGrl1LnhC4SygEs+mTbrjBu?=
 =?us-ascii?Q?C2Ta8oerbFOHJYKqtifUKeSqGrnsXuicq244vrm6ZYEqtIpnwQrAB98G4zwf?=
 =?us-ascii?Q?TAtA94BgS8cSE1Ebcaivf3USvV9JVJcQslBqzsnKYxgZzVCNun1C/km69wX+?=
 =?us-ascii?Q?9nORdkKX+7szL8Qp4UXbZveVCkYFFlL727LqXmkac0ddU7AZZcXiSgNtuhIt?=
 =?us-ascii?Q?Xu7YPvxSuqqRlzUpFNjj5Dq0ctdOzPD6xqu30/WW7ZS1IOrqVnBg6oZkTdq7?=
 =?us-ascii?Q?8dqEmmg2DXVlURkXnlTgNT39W8yLhf+0eLk9s64hXR5xJDZWyQqzH15uY22i?=
 =?us-ascii?Q?NpSamJ+s/VBtSkhYN5Rc8yI4UZ2A5mKKvd6ADijzPlTn1yVMh3BkMWjrIhzQ?=
 =?us-ascii?Q?2mBlEzuk4YCE9znHm5teOtkZV3nx1r/hnBTDRIJM8e+JAXOiR0D8FsxTRlXm?=
 =?us-ascii?Q?MRiNhO7LfJQECmf/ikwx9T40HYhHhNPmOk3ITMFLFnN1dqXQxjeFqg1JOd1G?=
 =?us-ascii?Q?tPVaIHBSD3o+sMofx25Bb9j9o6T9juyBJjYaORIr1B/XJMBOvV0X5Up4YUI2?=
 =?us-ascii?Q?ZsQzxomkUCJWdm546+Miu1AC/oa03b0zrV9MgBeVNgE7kKR7szD1sHTL3Jsr?=
 =?us-ascii?Q?IL159aW+rPj/D1laYOC7TF0XPZk8OcBER5yjOQXx5/PcgvCcMYCQ6TDv5vxo?=
 =?us-ascii?Q?qGjIX2GIY6Ri0xNg8zns3SEg8Z26cgkCq9J8rvdugtZeiR9t+O8Mjxs0Mju2?=
 =?us-ascii?Q?pluapZDybuL6OHB7kFwOWI6uKA0EkdsfEQlk0vUS8o4tR+hhhmWP71TAKpRW?=
 =?us-ascii?Q?tKSHCx1iz0c2m85DFt5oPbIGM8M8gTho72Qqk/PPkM68OoTEKIfT9hO5Dmy9?=
 =?us-ascii?Q?j9hZpczLTITWFxTgGxA7pgCGhRyyyzGHSBoWz11yJfF3BGW/HjtQHIXzgvFy?=
 =?us-ascii?Q?i9LP6WKxVhOEhK9KP63ECuaQsc+Ws9Mm3/UTI7Z476GUiXNW2p/6WONRAo0x?=
 =?us-ascii?Q?+dVZB1Igvx0uSuDHTCwZnPJrkdcZ3fep/Hos2xfejGNE4QDZPKFMInx7FCxC?=
 =?us-ascii?Q?/I+eWMO7jboAnXiP2CDChtcl/lhSB6TmA3Yd46YB0WLVEJGyT5/x2NV/5zCq?=
 =?us-ascii?Q?DRsJUP/+nw1eN8a+3FeBqJHYBqQM5XFgDq9ocWcBC9U4Z8OafCKXEiS4kmh5?=
 =?us-ascii?Q?6dbjuk8s1YJVOVRn3jZu0uFvDowPVxo4ANUzJMfQt9UaBmk5lr0JtCNrPaOD?=
 =?us-ascii?Q?F9HVSBnmAjhgmfu+OFzvYIrpiV3T2+9vIhwRPk75vfoFkZEbmuthXolfICAC?=
 =?us-ascii?Q?qMIH6SrNHYOEUwDvaXaR8sxQd81Y34VuXQwbWtO7X7aZuq3TfOpnTGiGIFLT?=
 =?us-ascii?Q?UNz5LLt9swng/9aMcuz3BDDRUZMIcEsX636yMJQcZlUQ0jLvF2/OBtdcxbf8?=
 =?us-ascii?Q?2TnXd1uQZLAEEXR5OpEhtfLy06B8wPzW2NRAkn0jQuW8ybIzuSIsLenvLdgn?=
 =?us-ascii?Q?OtJpZK9eyS46fSXPLyK3RcSFSXIcG21y/3xVerq55lyNGb+a57SdAojoRxG/?=
 =?us-ascii?Q?16fwMsjZCPNl95UM/ErhaaJOlu155KZ0JC+qkQQd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6RY/aGt7OBD1D8djPNKh/WzyKiUcL0LrJ42rkDcyrS5UC8mDT75YCFLC07hjT4UPUe0NB0YPRvsiwBCKs/R5acI9SGYc8C0uZLtiuEzSJ62xIqv6mjbkD/Err9INMlR/jXnyA8kZ+CYBa/6jHambiJuZkTiiYj/d0aqRh8Cgmwp8dw5DSMWTDHGY6q3qo3em0EfmjlIuDxjJH2bzUZ7hQW5yScog3jEmtPcdgYOIxgKlwl68pG9GKjizpmvFLPIsQqViO9bGKe+A4P3CWD1ABt/bYxmDAbJH9Ommzv1u8i54XqVqbASBS752Z5V93VeZsq4wQm+wuEv1yoYL57ixunlWUQ8QOx1dMj12nCS8d+RAsDdJpuxv3/tQGI3eDwadeez3jsFP04vsSarhBRuymJIVoqZBLQSy6+ZuNYH4ZUSN8P3mY+aSfEfPUH4jn/kI/R0oraBXzGb4nHTTIuE0qhp54W0Sa05pNHMNOPHne9UMGZTcYuKG6nrAccqQ+0UGhf7vt57a3p+chbPkytcGPHiHrgbWpFrxoR/yyWbKP1R0//a/3B8I0gEhq9qcC333vB4RUABGbiBOCYfP175c87LeR3v6cI0bmnpu4a6LfmHweWLMQfNQYQuAv+7F/eHcRc5PvtQFeflfLftgme81ppJ/ZbmIUDetUdc2otgYOkRhymwONN1NP2+3SrH9XNYxwIB5QJqnb2Lr5k+q+2kXhRsbjHMI4Vt2OyncJO7R6t3oXALHP8GkASHcrIdqaiIZ+slQkTluJoCvPGd330rgL2lF2k/nEwGeLhkkPB6AFZ5yobLODL65icoBmBQ9qDPPM+BzYT6Metvy5rCm+je9OGLcpPjuY2zGTMLTvS1SOB6wdbnuJS3wCoQpunhj9R8Y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2c514a-7ef9-40a2-eb95-08dbdc79efc6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:34:07.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBJiRoNZ2/iak8cVDcNkDT+fsJaEa0QoW94vTgFa8ezhzsfBX9OiNd4gZRDnAGu/SgbjPokMI9kVdbS0vbI+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_14,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030123
X-Proofpoint-ORIG-GUID: __S9U0Mw7mzi1Io3r3Wkpy9T6SBi-AvG
X-Proofpoint-GUID: __S9U0Mw7mzi1Io3r3Wkpy9T6SBi-AvG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 03, 2023 at 12:08:04PM +1100, NeilBrown wrote:
> On Fri, 03 Nov 2023, Chuck Lever III wrote:
> > 
> > > On Nov 2, 2023, at 1:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > On Fri, 2023-11-03 at 07:03 +1100, NeilBrown wrote:
> > >> On Thu, 02 Nov 2023, Jeff Layton wrote:
> > >>> On Wed, 2023-11-01 at 11:57 +1100, NeilBrown wrote:
> > >>>> The NFSv4 protocol allows state to be revoked by the admin and has error
> > >>>> codes which allow this to be communicated to the client.
> > >>>> 
> > >>>> This patch
> > >>>> - introduces 3 new state-id types for revoked open, lock, and
> > >>>>   delegation state.  This requires the bitmask to be 'short',
> > >>>>   not 'char'
> > >>>> - reports NFS4ERR_ADMIN_REVOKED when these are accessed
> > >>>> - introduces a per-client counter of these states and returns
> > >>>>   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
> > >>>>   Decrement this when freeing any admin-revoked state.
> > >>>> - introduces stub code to find all interesting states for a given
> > >>>>   superblock so they can be revoked via the 'unlock_filesystem'
> > >>>>   file in /proc/fs/nfsd/
> > >>>>   No actual states are handled yet.
> > >>>> 
> > >>>> Signed-off-by: NeilBrown <neilb@suse.de>
> > >>>> ---
> > >>>> fs/nfsd/nfs4layouts.c |  2 +-
> > >>>> fs/nfsd/nfs4state.c   | 93 +++++++++++++++++++++++++++++++++++++++----
> > >>>> fs/nfsd/nfsctl.c      |  1 +
> > >>>> fs/nfsd/nfsd.h        |  1 +
> > >>>> fs/nfsd/state.h       | 35 +++++++++++-----
> > >>>> fs/nfsd/trace.h       |  8 +++-
> > >>>> 6 files changed, 120 insertions(+), 20 deletions(-)
> > >>>> 
> > >>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > >>>> index 5e8096bc5eaa..09d0363bfbc4 100644
> > >>>> --- a/fs/nfsd/nfs4layouts.c
> > >>>> +++ b/fs/nfsd/nfs4layouts.c
> > >>>> @@ -269,7 +269,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
> > >>>> {
> > >>>> struct nfs4_layout_stateid *ls;
> > >>>> struct nfs4_stid *stid;
> > >>>> - unsigned char typemask = NFS4_LAYOUT_STID;
> > >>>> + unsigned short typemask = NFS4_LAYOUT_STID;
> > >>>> __be32 status;
> > >>>> 
> > >>>> if (create)
> > >>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > >>>> index 65fd5510323a..f3ba53a16105 100644
> > >>>> --- a/fs/nfsd/nfs4state.c
> > >>>> +++ b/fs/nfsd/nfs4state.c
> > >>>> @@ -1202,6 +1202,13 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
> > >>>> return NULL;
> > >>>> }
> > >>>> 
> > >>>> +void nfs4_unhash_stid(struct nfs4_stid *s)
> > >>>> +{
> > >>>> + if (s->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS)
> > >>>> + atomic_dec(&s->sc_client->cl_admin_revoked);
> > >>>> + s->sc_type = 0;
> > >>>> +}
> > >>>> +
> > >>>> void
> > >>>> nfs4_put_stid(struct nfs4_stid *s)
> > >>>> {
> > >>>> @@ -1215,6 +1222,7 @@ nfs4_put_stid(struct nfs4_stid *s)
> > >>>> return;
> > >>>> }
> > >>>> idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > >>>> + nfs4_unhash_stid(s);
> > >>>> nfs4_free_cpntf_statelist(clp->net, s);
> > >>>> spin_unlock(&clp->cl_lock);
> > >>>> s->sc_free(s);
> > >>>> @@ -1265,11 +1273,6 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
> > >>>> nfs4_put_stid(&dp->dl_stid);
> > >>>> }
> > >>>> 
> > >>>> -void nfs4_unhash_stid(struct nfs4_stid *s)
> > >>>> -{
> > >>>> - s->sc_type = 0;
> > >>>> -}
> > >>>> -
> > >>>> /**
> > >>>>  * nfs4_delegation_exists - Discover if this delegation already exists
> > >>>>  * @clp:     a pointer to the nfs4_client we're granting a delegation to
> > >>>> @@ -1536,6 +1539,7 @@ static void put_ol_stateid_locked(struct nfs4_ol_stateid *stp,
> > >>>> }
> > >>>> 
> > >>>> idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > >>>> + nfs4_unhash_stid(s);
> > >>>> list_add(&stp->st_locks, reaplist);
> > >>>> }
> > >>>> 
> > >>>> @@ -1680,6 +1684,53 @@ static void release_openowner(struct nfs4_openowner *oo)
> > >>>> nfs4_put_stateowner(&oo->oo_owner);
> > >>>> }
> > >>>> 
> > >>>> +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
> > >>>> +   struct super_block *sb,
> > >>>> +   unsigned short sc_types)
> > >>>> +{
> > >>>> + unsigned long id, tmp;
> > >>>> + struct nfs4_stid *stid;
> > >>>> +
> > >>>> + spin_lock(&clp->cl_lock);
> > >>>> + idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> > >>>> + if ((stid->sc_type & sc_types) &&
> > >>>> +     stid->sc_file->fi_inode->i_sb == sb) {
> > >>>> + refcount_inc(&stid->sc_count);
> > >>>> + break;
> > >>>> + }
> > >>>> + spin_unlock(&clp->cl_lock);
> > >>>> + return stid;
> > >>>> +}
> > >>>> +
> > >>>> +void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> > >>>> +{
> > >>>> + struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > >>>> + unsigned int idhashval;
> > >>>> + unsigned short sc_types;
> > >>>> +
> > >>>> + sc_types = 0;
> > >>>> +
> > >>>> + spin_lock(&nn->client_lock);
> > >>>> + for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > >>>> + struct list_head *head = &nn->conf_id_hashtbl[idhashval];
> > >>>> + struct nfs4_client *clp;
> > >>>> + retry:
> > >>>> + list_for_each_entry(clp, head, cl_idhash) {
> > >>>> + struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
> > >>>> +   sc_types);
> > >>>> + if (stid) {
> > >>>> + spin_unlock(&nn->client_lock);
> > >>>> + switch (stid->sc_type) {
> > >>>> + }
> > >>>> + nfs4_put_stid(stid);
> > >>>> + spin_lock(&nn->client_lock);
> > >>>> + goto retry;
> > >>>> + }
> > >>>> + }
> > >>>> + }
> > >>>> + spin_unlock(&nn->client_lock);
> > >>>> +}
> > >>>> +
> > >>>> static inline int
> > >>>> hash_sessionid(struct nfs4_sessionid *sessionid)
> > >>>> {
> > >>>> @@ -2465,7 +2516,8 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
> > >>>> }
> > >>>> 
> > >>>> static struct nfs4_stid *
> > >>>> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
> > >>>> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> > >>>> +      unsigned short typemask)
> > >>>> {
> > >>>> struct nfs4_stid *s;
> > >>>> 
> > >>>> @@ -2549,6 +2601,8 @@ static int client_info_show(struct seq_file *m, void *v)
> > >>>> }
> > >>>> seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
> > >>>> seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> > >>>> + seq_printf(m, "admin-revoked states: %d\n",
> > >>>> +    atomic_read(&clp->cl_admin_revoked));
> > >>>> drop_client(clp);
> > >>>> 
> > >>>> return 0;
> > >>>> @@ -4108,6 +4162,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >>>> }
> > >>>> if (!list_empty(&clp->cl_revoked))
> > >>>> seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> > >>>> + if (atomic_read(&clp->cl_admin_revoked))
> > >>>> + seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
> > >>>> out_no_session:
> > >>>> if (conn)
> > >>>> free_conn(conn);
> > >>>> @@ -5200,6 +5256,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
> > >>>> status = nfserr_deleg_revoked;
> > >>>> goto out;
> > >>>> }
> > >>>> + if (deleg->dl_stid.sc_type == NFS4_ADMIN_REVOKED_DELEG_STID) {
> > >>>> + nfs4_put_stid(&deleg->dl_stid);
> > >>>> + status = nfserr_admin_revoked;
> > >>>> + goto out;
> > >>>> + }
> > >>>> flags = share_access_to_flags(open->op_share_access);
> > >>>> status = nfs4_check_delegmode(deleg, flags);
> > >>>> if (status) {
> > >>>> @@ -6478,6 +6539,11 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> > >>>> case NFS4_REVOKED_DELEG_STID:
> > >>>> status = nfserr_deleg_revoked;
> > >>>> break;
> > >>>> + case NFS4_ADMIN_REVOKED_STID:
> > >>>> + case NFS4_ADMIN_REVOKED_LOCK_STID:
> > >>>> + case NFS4_ADMIN_REVOKED_DELEG_STID:
> > >>>> + status = nfserr_admin_revoked;
> > >>>> + break;
> > >>>> case NFS4_OPEN_STID:
> > >>>> case NFS4_LOCK_STID:
> > >>>> status = nfsd4_check_openowner_confirmed(openlockstateid(s));
> > >>>> @@ -6496,7 +6562,7 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> > >>>> 
> > >>>> __be32
> > >>>> nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > >>>> -      stateid_t *stateid, unsigned char typemask,
> > >>>> +      stateid_t *stateid, unsigned short typemask,
> > >>>>      struct nfs4_stid **s, struct nfsd_net *nn)
> > >>>> {
> > >>>> __be32 status;
> > >>>> @@ -6512,6 +6578,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > >>>> else if (typemask & NFS4_DELEG_STID)
> > >>>> typemask |= NFS4_REVOKED_DELEG_STID;
> > >>>> 
> > >>>> + if (typemask & NFS4_OPEN_STID)
> > >>>> + typemask |= NFS4_ADMIN_REVOKED_STID;
> > >>>> + if (typemask & NFS4_LOCK_STID)
> > >>>> + typemask |= NFS4_ADMIN_REVOKED_LOCK_STID;
> > >>>> + if (typemask & NFS4_DELEG_STID)
> > >>>> + typemask |= NFS4_ADMIN_REVOKED_DELEG_STID;
> > >>>> +
> > >>>> if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > >>>> CLOSE_STATEID(stateid))
> > >>>> return nfserr_bad_stateid;
> > >>>> @@ -6532,6 +6605,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > >>>> return nfserr_deleg_revoked;
> > >>>> return nfserr_bad_stateid;
> > >>>> }
> > >>>> + if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
> > >>>> + nfs4_put_stid(stid);
> > >>>> + return nfserr_admin_revoked;
> > >>>> + }
> > >>>> *s = stid;
> > >>>> return nfs_ok;
> > >>>> }
> > >>>> @@ -6899,7 +6976,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
> > >>>>  */
> > >>>> static __be32
> > >>>> nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> > >>>> -  stateid_t *stateid, char typemask,
> > >>>> +  stateid_t *stateid, unsigned short typemask,
> > >>>>  struct nfs4_ol_stateid **stpp,
> > >>>>  struct nfsd_net *nn)
> > >>>> {
> > >>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > >>>> index 739ed5bf71cd..50368eec86b0 100644
> > >>>> --- a/fs/nfsd/nfsctl.c
> > >>>> +++ b/fs/nfsd/nfsctl.c
> > >>>> @@ -281,6 +281,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
> > >>>>  * 3.  Is that directory the root of an exported file system?
> > >>>>  */
> > >>>> error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> > >>>> + nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> > >>>> 
> > >>>> path_put(&path);
> > >>>> return error;
> > >>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > >>>> index f5ff42f41ee7..d46203eac3c8 100644
> > >>>> --- a/fs/nfsd/nfsd.h
> > >>>> +++ b/fs/nfsd/nfsd.h
> > >>>> @@ -280,6 +280,7 @@ void nfsd_lockd_shutdown(void);
> > >>>> #define nfserr_no_grace cpu_to_be32(NFSERR_NO_GRACE)
> > >>>> #define nfserr_reclaim_bad cpu_to_be32(NFSERR_RECLAIM_BAD)
> > >>>> #define nfserr_badname cpu_to_be32(NFSERR_BADNAME)
> > >>>> +#define nfserr_admin_revoked cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
> > >>>> #define nfserr_cb_path_down cpu_to_be32(NFSERR_CB_PATH_DOWN)
> > >>>> #define nfserr_locked cpu_to_be32(NFSERR_LOCKED)
> > >>>> #define nfserr_wrongsec cpu_to_be32(NFSERR_WRONGSEC)
> > >>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > >>>> index f96eaa8e9413..3af5ab55c978 100644
> > >>>> --- a/fs/nfsd/state.h
> > >>>> +++ b/fs/nfsd/state.h
> > >>>> @@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
> > >>>>  */
> > >>>> struct nfs4_stid {
> > >>>> refcount_t sc_count;
> > >>>> -#define NFS4_OPEN_STID 1
> > >>>> -#define NFS4_LOCK_STID 2
> > >>>> -#define NFS4_DELEG_STID 4
> > >>>> + struct list_head sc_cp_list;
> > >>>> + unsigned short sc_type;
> > >>> 
> > >>> Should we just go ahead and make this a full 32-bit word? We seem to
> > >>> keep adding flags to this field, and I doubt we're saving anything by
> > >>> making this a short.
> > >>> 
> > >>>> +#define NFS4_OPEN_STID BIT(0)
> > >>>> +#define NFS4_LOCK_STID BIT(1)
> > >>>> +#define NFS4_DELEG_STID BIT(2)
> > >>>> /* For an open stateid kept around *only* to process close replays: */
> > >>>> -#define NFS4_CLOSED_STID 8
> > >>>> +#define NFS4_CLOSED_STID BIT(3)
> > >>>> /* For a deleg stateid kept around only to process free_stateid's: */
> > >>>> -#define NFS4_REVOKED_DELEG_STID 16
> > >>>> -#define NFS4_CLOSED_DELEG_STID 32
> > >>>> -#define NFS4_LAYOUT_STID 64
> > >>>> - struct list_head sc_cp_list;
> > >>>> - unsigned char sc_type;
> > >>>> +#define NFS4_REVOKED_DELEG_STID BIT(4)
> > >>>> +#define NFS4_CLOSED_DELEG_STID BIT(5)
> > >>>> +#define NFS4_LAYOUT_STID BIT(6)
> > >>>> +#define NFS4_ADMIN_REVOKED_STID BIT(7)
> > >>>> +#define NFS4_ADMIN_REVOKED_LOCK_STID BIT(8)
> > >>>> +#define NFS4_ADMIN_REVOKED_DELEG_STID BIT(9)
> > >>>> +#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID | \
> > >>>> +      NFS4_ADMIN_REVOKED_LOCK_STID | \
> > >>>> +      NFS4_ADMIN_REVOKED_DELEG_STID)
> > >>> 
> > >>> Not a specific criticism of these patches, since this problem preexists
> > >>> them, but I really dislike the way that sc_type is used as a bitmask,
> > >>> but also sort of like an enum. In some cases, we test for specific flags
> > >>> in the mask, and in other cases (e.g. states_show), we treat them as
> > >>> discrete values to feed it to a switch().
> > >>> 
> > >>> Personally, I'd find this less confusing if we just treat this as a set
> > >>> of flags full-stop. We could leave the low-order bits to show the real
> > >>> type (open, lock, deleg, etc.) and just mask off the high-order bits
> > >>> when we need to feed it to a switch statement.
> > >>> 
> > >>> For instance above, we're adding 3 new NFS4_ADMIN_REVOKED values, but we
> > >>> could (in theory) just have a flag in there that says NFS4_ADMIN_REVOKED
> > >>> and leave the old type bit in place instead of changing it to a new
> > >>> discrete sc_type value.
> > >> 
> > >> I agree.
> > >> Bits might be:
> > >>    OPEN
> > >>    LOCK
> > >>    DELEG
> > >>    LAYOUT
> > >>    CLOSED (combines with OPEN or DELEG)
> > >>    REVOKED (combines with DELEG)
> > >>    ADMIN_REVOKED (combined with OPEN, LOCK, DELEG.  Sets REVOKED when
> > >>                   with DELEG)
> > >> 
> > >> so we could go back to a char :-)  Probably sensible to use unsigned int
> > >> though.
> > >> 
> > > 
> > > Yeah, a u32 would be best I think. It'll just fill an existing hole on
> > > my box (x86_64), according to pahole:
> > > 
> > > unsigned char              sc_type;              /*    24     1 */
> > > 
> > > /* XXX 3 bytes hole, try to pack */
> > > 
> > >> For updates the rule would be that bits can be set but never cleared so
> > >> you don't need locking to read unless you care about a bit that can be
> > >> changed.
> > >> 
> > > 
> > > Probably for the low order OPEN/LOCK/DELEG bits, the rule should be that
> > > they never change. We can never convert from one to another since they
> > > come out of different slabcaches. It's probably worthwhile to leave a
> > > few low order bits carved out for new types in the future too. e.g.
> > > directory delegations...
> > > 
> > > Maybe we should rename the field too? How about "sc_mode" since this is
> > > starting to resemble the i_mode field in some ways (type and permissions
> > > squashed together).
> > 
> > In that case, two separate u16 fields might be better.
> > 
> 
> Here is a first attempt.  It compiles but I haven't tried running or
> thought about what testing would be appropriate.
> I'll be working on other things next week but I hope to pick this up
> again the following week and process any feedback, then see how my
> admin-revoke patch set fits on this new code.
> 
> All comments most welcome.
> 
> Thanks,
> NeilBrown
> 
> 
> From: NeilBrown <neilb@suse.de>
> Date: Fri, 3 Nov 2023 11:43:55 +1100
> Subject: [PATCH] nfsd: tidy up sc_type
> 
> sc_type identifies the type of a state - open, lock, deleg, layout - and
> also the status of a state - closed or revoked.
> 
> This is a bit untidy and could get worse when "admin-revoked" states are
> added.  So try to clean it up.
> 
> The type is now all that is stored in sc_type.  This is zero when the
> state is first added to the idr (causing it to be ignored), and if then
> set appropriately once it is fully initialised.  It is set under
> ->cl_lock to ensure atomicity w.r.t lookup.  It is (now) never cleared.
> 
> This is still a bit-set even though at most one bit is set.  This allows
> lookup functions to be given a bitmap of acceptable types.
> 
> cl_type is now an unsigned short rather than char.  There is no value in
> restricting to just 8 bits.
> 
> The status is stored in a separate short named "cl_status".  It has two
> flags: NFS4_STID_CLOSED and NFS4_STID_REVOKED.
> CLOSED combines NFS4_CLOSED_STID, NFS4_CLOSED_DELEG_STID, and is used
> for LOCK_STID instead of setting the sc_type to zero.
> These flags are only ever set, never cleared.
> For deleg stateids they are set under the global state_lock.
> For open and lock stateids they are set under ->cl_lock.
> 
> Other changes here - some of which could be split out...
> 
> - When a delegation is revoked, the type was previously set to
>    NFS4_CLOSED_DELEG_STID and then NFS4_REVOKED_DELEG_STID.
>   This might open a race window.  That window no longer exists.
> 
> - NFS4_STID_REVOKED (previously NFS4_REVOKED_DELEG_STID) is only set
>   for ->minorversion>0, so I removed all the tests on minorversion when
>   that status has been detected.
> 
> - nfs4_unhash_stid() has been removed, and we never set sc_type = 0.
>   This was only used for LOCK stids and they now use NFS4_STID_CLOSED
> 
> - ->cl_lock is now hel when hash_delegation_locked() is called, so
>   that the locking rules for setting ->sc_type are followed.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4layouts.c |   4 +-
>  fs/nfsd/nfs4state.c   | 165 ++++++++++++++++++++----------------------
>  fs/nfsd/state.h       |  37 +++++++---
>  fs/nfsd/trace.h       |  25 +++----
>  4 files changed, 119 insertions(+), 112 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 5e8096bc5eaa..678bef3a7f15 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -269,13 +269,13 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
>  {
>  	struct nfs4_layout_stateid *ls;
>  	struct nfs4_stid *stid;
> -	unsigned char typemask = NFS4_LAYOUT_STID;
> +	unsigned short typemask = NFS4_LAYOUT_STID;
>  	__be32 status;
>  
>  	if (create)
>  		typemask |= (NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID);
>  
> -	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &stid,
> +	status = nfsd4_lookup_stateid(cstate, stateid, typemask, 0, &stid,
>  			net_generic(SVC_NET(rqstp), nfsd_net_id));
>  	if (status)
>  		goto out;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 65fd5510323a..551a86a796ed 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1265,11 +1265,6 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
>  	nfs4_put_stid(&dp->dl_stid);
>  }
>  
> -void nfs4_unhash_stid(struct nfs4_stid *s)
> -{
> -	s->sc_type = 0;
> -}
> -
>  /**
>   * nfs4_delegation_exists - Discover if this delegation already exists
>   * @clp:     a pointer to the nfs4_client we're granting a delegation to
> @@ -1317,6 +1312,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
>  
>  	lockdep_assert_held(&state_lock);
>  	lockdep_assert_held(&fp->fi_lock);
> +	lockdep_assert_held(&clp->cl_lock);
>  
>  	if (nfs4_delegation_exists(clp, fp))
>  		return -EAGAIN;
> @@ -1333,7 +1329,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
>  }
>  
>  static bool
> -unhash_delegation_locked(struct nfs4_delegation *dp)
> +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short state)
>  {
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
>  
> @@ -1342,7 +1338,10 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
>  	if (!delegation_hashed(dp))
>  		return false;
>  
> -	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
> +	if (dp->dl_stid.sc_client->cl_minorversion == 0)
> +		state = NFS4_STID_CLOSED;
> +	dp->dl_stid.sc_status |= state | NFS4_STID_CLOSED;
> +
>  	/* Ensure that deleg break won't try to requeue it */
>  	++dp->dl_time;
>  	spin_lock(&fp->fi_lock);
> @@ -1358,7 +1357,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>  	bool unhashed;
>  
>  	spin_lock(&state_lock);
> -	unhashed = unhash_delegation_locked(dp);
> +	unhashed = unhash_delegation_locked(dp, NFS4_STID_CLOSED);
>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -1372,9 +1371,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
>  
> -	if (clp->cl_minorversion) {
> +	if (dp->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		spin_lock(&clp->cl_lock);
> -		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
>  		refcount_inc(&dp->dl_stid.sc_count);
>  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
>  		spin_unlock(&clp->cl_lock);
> @@ -1382,8 +1380,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  	destroy_unhashed_deleg(dp);
>  }
>  
> -/* 
> - * SETCLIENTID state 
> +/*
> + * SETCLIENTID state
>   */
>  
>  static unsigned int clientid_hashval(u32 id)
> @@ -1546,7 +1544,6 @@ static bool unhash_lock_stateid(struct nfs4_ol_stateid *stp)
>  	if (!unhash_ol_stateid(stp))
>  		return false;
>  	list_del_init(&stp->st_locks);
> -	nfs4_unhash_stid(&stp->st_stid);
>  	return true;
>  }
>  
> @@ -1557,6 +1554,7 @@ static void release_lock_stateid(struct nfs4_ol_stateid *stp)
>  
>  	spin_lock(&clp->cl_lock);
>  	unhashed = unhash_lock_stateid(stp);
> +	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
>  	spin_unlock(&clp->cl_lock);
>  	if (unhashed)
>  		nfs4_put_stid(&stp->st_stid);
> @@ -1625,6 +1623,7 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
>  	LIST_HEAD(reaplist);
>  
>  	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
>  	if (unhash_open_stateid(stp, &reaplist))
>  		put_ol_stateid_locked(stp, &reaplist);
>  	spin_unlock(&stp->st_stid.sc_client->cl_lock);
> @@ -2233,7 +2232,7 @@ __destroy_client(struct nfs4_client *clp)
>  	spin_lock(&state_lock);
>  	while (!list_empty(&clp->cl_delegations)) {
>  		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
> -		WARN_ON(!unhash_delegation_locked(dp));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_CLOSED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -2465,14 +2464,16 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
>  }
>  
>  static struct nfs4_stid *
> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> +		     unsigned short typemask, unsigned short ok_states)
>  {
>  	struct nfs4_stid *s;
>  
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, t);
>  	if (s != NULL) {
> -		if (typemask & s->sc_type)
> +		if ((s->sc_status & ~ok_states) == 0 &&
> +		    (typemask & s->sc_type))
>  			refcount_inc(&s->sc_count);
>  		else
>  			s = NULL;
> @@ -4582,7 +4583,8 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
>  			continue;
>  		if (local->st_stateowner != &oo->oo_owner)
>  			continue;
> -		if (local->st_stid.sc_type == NFS4_OPEN_STID) {
> +		if (local->st_stid.sc_type == NFS4_OPEN_STID &&
> +		    !(local->st_stid.sc_status & NFS4_STID_CLOSED)) {
>  			ret = local;
>  			refcount_inc(&ret->st_stid.sc_count);
>  			break;
> @@ -4596,17 +4598,10 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
>  	__be32 ret = nfs_ok;
>  
> -	switch (s->sc_type) {
> -	default:
> -		break;
> -	case 0:
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
> -		ret = nfserr_bad_stateid;
> -		break;
> -	case NFS4_REVOKED_DELEG_STID:
> +	if (s->sc_status & NFS4_STID_REVOKED)
>  		ret = nfserr_deleg_revoked;
> -	}
> +	else if (s->sc_status & NFS4_STID_CLOSED)
> +		ret = nfserr_bad_stateid;
>  	return ret;
>  }
>  
> @@ -4919,9 +4914,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
>  
>  	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
>  
> -	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
> -	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
> -	        return 1;
> +	if (dp->dl_stid.sc_status)
> +		/* CLOSED or REVOKED */
> +		return 1;
>  
>  	switch (task->tk_status) {
>  	case 0:
> @@ -5170,8 +5165,7 @@ static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl, statei
>  {
>  	struct nfs4_stid *ret;
>  
> -	ret = find_stateid_by_type(cl, s,
> -				NFS4_DELEG_STID|NFS4_REVOKED_DELEG_STID);
> +	ret = find_stateid_by_type(cl, s, NFS4_DELEG_STID, 0);
>  	if (!ret)
>  		return NULL;
>  	return delegstateid(ret);
> @@ -5194,10 +5188,9 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
>  	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
>  	if (deleg == NULL)
>  		goto out;
> -	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> +	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
> -		if (cl->cl_minorversion)
> -			status = nfserr_deleg_revoked;
> +		status = nfserr_deleg_revoked;
>  		goto out;
>  	}
>  	flags = share_access_to_flags(open->op_share_access);
> @@ -5609,12 +5602,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		goto out_unlock;
>  
>  	spin_lock(&state_lock);
> +	spin_lock(&clp->cl_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (fp->fi_had_conflict)
>  		status = -EAGAIN;
>  	else
>  		status = hash_delegation_locked(dp, fp);
>  	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&clp->cl_lock);
>  	spin_unlock(&state_lock);
>  
>  	if (status)
> @@ -5840,7 +5835,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  	} else {
>  		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>  		if (status) {
> -			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
>  			mutex_unlock(&stp->st_mutex);
>  			goto out;
> @@ -6232,7 +6226,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>  		if (!state_expired(&lt, dp->dl_time))
>  			break;
> -		WARN_ON(!unhash_delegation_locked(dp));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_REVOKED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -6471,22 +6465,20 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	status = nfsd4_stid_check_stateid_generation(stateid, s, 1);
>  	if (status)
>  		goto out_unlock;
> +	status = nfsd4_verify_open_stid(s);
> +	if (status)
> +		goto out_unlock;
> +
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
>  		status = nfs_ok;
>  		break;
> -	case NFS4_REVOKED_DELEG_STID:
> -		status = nfserr_deleg_revoked;
> -		break;
>  	case NFS4_OPEN_STID:
>  	case NFS4_LOCK_STID:
>  		status = nfsd4_check_openowner_confirmed(openlockstateid(s));
>  		break;
>  	default:
>  		printk("unknown stateid type %x\n", s->sc_type);
> -		fallthrough;
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
>  		status = nfserr_bad_stateid;
>  	}
>  out_unlock:
> @@ -6496,7 +6488,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  
>  __be32
>  nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> +		     stateid_t *stateid,
> +		     unsigned short typemask, unsigned short statemask,
>  		     struct nfs4_stid **s, struct nfsd_net *nn)
>  {
>  	__be32 status;
> @@ -6507,10 +6500,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  	 *  only return revoked delegations if explicitly asked.
>  	 *  otherwise we report revoked or bad_stateid status.
>  	 */
> -	if (typemask & NFS4_REVOKED_DELEG_STID)
> +	if (statemask & NFS4_STID_REVOKED)
>  		return_revoked = true;
> -	else if (typemask & NFS4_DELEG_STID)
> -		typemask |= NFS4_REVOKED_DELEG_STID;
>  
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
> @@ -6523,14 +6514,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  	}
>  	if (status)
>  		return status;
> -	stid = find_stateid_by_type(cstate->clp, stateid, typemask);
> +	stid = find_stateid_by_type(cstate->clp, stateid,
> +				    typemask, statemask & NFS4_STID_CLOSED);
>  	if (!stid)
>  		return nfserr_bad_stateid;
> -	if ((stid->sc_type == NFS4_REVOKED_DELEG_STID) && !return_revoked) {
> +	if ((stid->sc_status & NFS4_STID_REVOKED) && !return_revoked) {
>  		nfs4_put_stid(stid);
> -		if (cstate->minorversion)
> -			return nfserr_deleg_revoked;
> -		return nfserr_bad_stateid;
> +		return nfserr_deleg_revoked;
>  	}
>  	*s = stid;
>  	return nfs_ok;
> @@ -6541,7 +6531,7 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>  {
>  	struct nfsd_file *ret = NULL;
>  
> -	if (!s)
> +	if (!s || s->sc_status)
>  		return NULL;
>  
>  	switch (s->sc_type) {
> @@ -6664,7 +6654,8 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>  		goto out;
>  
>  	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
> -			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> +				     NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> +				     0);
>  	if (*stid)
>  		status = nfs_ok;
>  	else
> @@ -6722,7 +6713,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  
>  	status = nfsd4_lookup_stateid(cstate, stateid,
>  				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> -				&s, nn);
> +				0, &s, nn);
>  	if (status == nfserr_bad_stateid)
>  		status = find_cpntf_state(nn, stateid, &s);
>  	if (status)
> @@ -6740,9 +6731,6 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	case NFS4_LOCK_STID:
>  		status = nfs4_check_olstateid(openlockstateid(s), flags);
>  		break;
> -	default:
> -		status = nfserr_bad_stateid;
> -		break;
>  	}
>  	if (status)
>  		goto out;
> @@ -6821,11 +6809,20 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, stateid);
> -	if (!s)
> +	if (!s || s->sc_status & NFS4_STID_CLOSED)
>  		goto out_unlock;
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
> +		if (s->sc_status & NFS4_STID_REVOKED) {
> +			spin_unlock(&s->sc_lock);
> +			dp = delegstateid(s);
> +			list_del_init(&dp->dl_recall_lru);
> +			spin_unlock(&cl->cl_lock);
> +			nfs4_put_stid(s);
> +			ret = nfs_ok;
> +			goto out;
> +		}
>  		ret = nfserr_locks_held;
>  		break;
>  	case NFS4_OPEN_STID:
> @@ -6840,14 +6837,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		spin_unlock(&cl->cl_lock);
>  		ret = nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	case NFS4_REVOKED_DELEG_STID:
> -		spin_unlock(&s->sc_lock);
> -		dp = delegstateid(s);
> -		list_del_init(&dp->dl_recall_lru);
> -		spin_unlock(&cl->cl_lock);
> -		nfs4_put_stid(s);
> -		ret = nfs_ok;
> -		goto out;
>  	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
> @@ -6890,6 +6879,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
>   * @seqid: seqid (provided by client)
>   * @stateid: stateid (provided by client)
>   * @typemask: mask of allowable types for this operation
> + * @statemask: mask of allowed states: 0 or STID_CLOSED
>   * @stpp: return pointer for the stateid found
>   * @nn: net namespace for request
>   *
> @@ -6899,7 +6889,8 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
>   */
>  static __be32
>  nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> -			 stateid_t *stateid, char typemask,
> +			 stateid_t *stateid,
> +			 unsigned short typemask, unsigned short statemask,
>  			 struct nfs4_ol_stateid **stpp,
>  			 struct nfsd_net *nn)
>  {
> @@ -6910,7 +6901,8 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
>  	trace_nfsd_preprocess(seqid, stateid);
>  
>  	*stpp = NULL;
> -	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> +	status = nfsd4_lookup_stateid(cstate, stateid,
> +				      typemask, statemask, &s, nn);
>  	if (status)
>  		return status;
>  	stp = openlockstateid(s);
> @@ -6932,7 +6924,7 @@ static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cs
>  	struct nfs4_ol_stateid *stp;
>  
>  	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
> -						NFS4_OPEN_STID, &stp, nn);
> +					  NFS4_OPEN_STID, 0, &stp, nn);
>  	if (status)
>  		return status;
>  	oo = openowner(stp->st_stateowner);
> @@ -6963,8 +6955,8 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		return status;
>  
>  	status = nfs4_preprocess_seqid_op(cstate,
> -					oc->oc_seqid, &oc->oc_req_stateid,
> -					NFS4_OPEN_STID, &stp, nn);
> +					  oc->oc_seqid, &oc->oc_req_stateid,
> +					  NFS4_OPEN_STID, 0, &stp, nn);
>  	if (status)
>  		goto out;
>  	oo = openowner(stp->st_stateowner);
> @@ -7094,18 +7086,20 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> -	dprintk("NFSD: nfsd4_close on file %pd\n", 
> +	dprintk("NFSD: nfsd4_close on file %pd\n",
>  			cstate->current_fh.fh_dentry);
>  
>  	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
> -					&close->cl_stateid,
> -					NFS4_OPEN_STID|NFS4_CLOSED_STID,
> -					&stp, nn);
> +					  &close->cl_stateid,
> +					  NFS4_OPEN_STID, NFS4_STID_CLOSED,
> +					  &stp, nn);
>  	nfsd4_bump_seqid(cstate, status);
>  	if (status)
> -		goto out; 
> +		goto out;
>  
> -	stp->st_stid.sc_type = NFS4_CLOSED_STID;
> +	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
> +	spin_unlock(&stp->st_stid.sc_client->cl_lock);
>  
>  	/*
>  	 * Technically we don't _really_ have to increment or copy it, since
> @@ -7147,7 +7141,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
>  
> -	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, &s, nn);
> +	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, 0, &s, nn);
>  	if (status)
>  		goto out;
>  	dp = delegstateid(s);
> @@ -7601,9 +7595,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  							&lock_stp, &new);
>  	} else {
>  		status = nfs4_preprocess_seqid_op(cstate,
> -				       lock->lk_old_lock_seqid,
> -				       &lock->lk_old_lock_stateid,
> -				       NFS4_LOCK_STID, &lock_stp, nn);
> +						  lock->lk_old_lock_seqid,
> +						  &lock->lk_old_lock_stateid,
> +						  NFS4_LOCK_STID, 0, &lock_stp,
> +						  nn);
>  	}
>  	if (status)
>  		goto out;
> @@ -7916,8 +7911,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		 return nfserr_inval;
>  
>  	status = nfs4_preprocess_seqid_op(cstate, locku->lu_seqid,
> -					&locku->lu_stateid, NFS4_LOCK_STID,
> -					&stp, nn);
> +					  &locku->lu_stateid, NFS4_LOCK_STID, 0,
> +					  &stp, nn);
>  	if (status)
>  		goto out;
>  	nf = find_any_file(stp->st_stid.sc_file);
> @@ -8347,7 +8342,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> -		WARN_ON(!unhash_delegation_locked(dp));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_CLOSED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f96eaa8e9413..cf89fb6be9e1 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -88,17 +88,31 @@ struct nfsd4_callback_ops {
>   */
>  struct nfs4_stid {
>  	refcount_t		sc_count;
> -#define NFS4_OPEN_STID 1
> -#define NFS4_LOCK_STID 2
> -#define NFS4_DELEG_STID 4
> -/* For an open stateid kept around *only* to process close replays: */
> -#define NFS4_CLOSED_STID 8
> +
> +	/* A new stateid is added to the idr early before it is
> +	 * fully initialised.  Its sc_type is then zero.
> +	 * After initialisation the sc_type it set under cl_lock,
> +	 * and then never changes.
> +	 */
> +#define NFS4_OPEN_STID		BIT(0)
> +#define NFS4_LOCK_STID		BIT(1)
> +#define NFS4_DELEG_STID		BIT(2)
> +#define NFS4_LAYOUT_STID	BIT(3)
> +	unsigned short		sc_type;
> +/* state_lock protects sc_status for delegation stateids.
> + * ->cl_lock protects sc_status for open and lock stateids.
> + * ->st_mutex also protect sc_status for open stateids.
> + */
> +/*
> + * For an open stateid kept around *only* to process close replays.
> + * For deleg stateid, kept in idr until last reference is dropped.
> + */
> +#define NFS4_STID_CLOSED	BIT(0)
>  /* For a deleg stateid kept around only to process free_stateid's: */
> -#define NFS4_REVOKED_DELEG_STID 16
> -#define NFS4_CLOSED_DELEG_STID 32
> -#define NFS4_LAYOUT_STID 64
> +#define NFS4_STID_REVOKED	BIT(1)
> +	unsigned short		sc_status;
> +
>  	struct list_head	sc_cp_list;
> -	unsigned char		sc_type;
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
>  	struct nfs4_client	*sc_client;
> @@ -694,8 +708,9 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  		stateid_t *stateid, int flags, struct nfsd_file **filp,
>  		struct nfs4_stid **cstid);
>  __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> -		     struct nfs4_stid **s, struct nfsd_net *nn);
> +			    stateid_t *stateid, unsigned short typemask,
> +			    unsigned short statemask,
> +			    struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
>  int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index fbc0ccb40424..668b352faaea 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -641,31 +641,26 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
>  DEFINE_STATESEQID_EVENT(preprocess);
>  DEFINE_STATESEQID_EVENT(open_confirm);
>  
> -TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
> -TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
> -TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> -TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> -
>  #define show_stid_type(x)						\
>  	__print_flags(x, "|",						\
>  		{ NFS4_OPEN_STID,		"OPEN" },		\
>  		{ NFS4_LOCK_STID,		"LOCK" },		\
>  		{ NFS4_DELEG_STID,		"DELEG" },		\
> -		{ NFS4_CLOSED_STID,		"CLOSED" },		\
> -		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
> -		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
>  		{ NFS4_LAYOUT_STID,		"LAYOUT" })
>  
> +#define show_stid_status(x)						\
> +	__print_flags(x, "|",						\
> +		{ NFS4_STID_CLOSED,		"CLOSED" },		\
> +		{ NFS4_STID_REVOKED,		"REVOKED" })		\
> +
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(
>  		const struct nfs4_stid *stid
>  	),
>  	TP_ARGS(stid),
>  	TP_STRUCT__entry(
> -		__field(unsigned long, sc_type)
> +		__field(unsigned short, sc_type)
> +		__field(unsigned short, sc_status)

I'll let Jeff comment on the other areas. Here, I prefer that
anything that is passed to __print_flags or __print_symbolic be
stored in an unsigned long, since that's the type of the @val
argument to trace_print_symbols_seq(). That's why the sc_type
entry is already an unsigned long.

That way any type conversion that might be necessary is visible
(and controllable) in the TP_fast_assign section of the trace
point.

Note that these days, trace events are stored in the ring buffer
in a compressed form, so the actual size of record entries is
typically not critical.

(This is a nit/general comment -- I can fix this up when I apply
it if Jeff is happy with the rest of the patch).


>  		__field(int, sc_count)
>  		__field(u32, cl_boot)
>  		__field(u32, cl_id)
> @@ -676,16 +671,18 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  		const stateid_t *stp = &stid->sc_stateid;
>  
>  		__entry->sc_type = stid->sc_type;
> +		__entry->sc_status = stid->sc_status;
>  		__entry->sc_count = refcount_read(&stid->sc_count);
>  		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
>  		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
>  		__entry->si_id = stp->si_opaque.so_id;
>  		__entry->si_generation = stp->si_generation;
>  	),
> -	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s",
> +	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s state=%s",
>  		__entry->cl_boot, __entry->cl_id,
>  		__entry->si_id, __entry->si_generation,
> -		__entry->sc_count, show_stid_type(__entry->sc_type)
> +		__entry->sc_count, show_stid_type(__entry->sc_type),
> +		show_stid_status(__entry->sc_status)
>  	)
>  );
>  
> -- 
> 2.42.0
> 

-- 
Chuck Lever
