Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922697D72F7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 20:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjJYSJN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjJYSJC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 14:09:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DC81FE7;
        Wed, 25 Oct 2023 11:08:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwkiR004623;
        Wed, 25 Oct 2023 18:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=MEP5cl97p6mPGbq1Hl3XdfrAvsrwYRU5K/L71g7Xv7k=;
 b=UHprWP5BDhdvvLjgfg9MnOOlheNB0QFrfqgaT/l663g9yahflajYkdDb+5hqUth9iJ8P
 jE8CR/5k3wHziCIMhDAC34Kwrmq0QPhGjH3WCtVPRQq1ARXKvi0rXe0ZivojbTSaxBnh
 hDKN5jVyvo0QvK8aOS5hKwsr3+pJDm/2iCNMTftehQPVdmf5pj6WCQb4QIuwOstu39x8
 12g+FNbfpEuGUj8yow0ih7B8DSF48MxosKYkaaJ6z0a0jkl1roPyCiXvbZZXXxXuCPYU
 0k865NGSB8GM5niI00d7hQyS71wOriB3WxYXxbK6wyVbKktQeH6cQd/uw7v8ojMliZ/J fQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e38dty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:07:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PHMTj6014306;
        Wed, 25 Oct 2023 18:07:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfm98my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUd6fk42/qYX2553SOO0rLgw3/bslyz/yq00PAb8NecjZtzuVqiej1dNHyu0jRmYswdHFP8MDkp4zIiHACKYA1yyJbE34yTWBlSNt08yqurkgvxhoMwpfX1NXSzX39Y8vi+Iel02tjHbP4QQ/Ro48Vff9iXSt6NufG7bkXr2VUV4kVJOZfegf760eEVzhkk1SBEa/Nl6MQf9C5Nkzf0W7EcL83VpVZfOYDrL5Ld3CbcqNvbRY7OilAPV9Buni2aD/eS2MoSIi5b5BvUv8djzjvua7YyiwHdqkkYltjQdSok2/DaMyBTc8QMe6jP5kHpwL1CGjfH2a2yLqeDmYkTb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEP5cl97p6mPGbq1Hl3XdfrAvsrwYRU5K/L71g7Xv7k=;
 b=lTShcsdRGDWP2XFOgP9ehHw5XcUMntEU9R1YRRBMkRm8fV18bLCtLJ5gSC9YKJ03WFAn8tmARtMbAHUlOs08MGh43npDBqEm7S76th+mo7NEuQ506o61yDbisrAan+0PieAvaio1dwXW1K16jyiFxa+jvP6QbmXWSfcMIl6dPMmPEY1ZATgmIcY0gZ4FvuQ9b8Wv6mGAZX8oUFZSM1ocHMIsJsi7Q73HPpPVoiacQcMbrKShI+nd2S50qV+nD4NSV1t/jHW6tNcUbKAf82KGkwS2nJjCoiSbI3axpkKHxSStmbOwoloXglJczBFLrzIOc+PduDEvwRPjPvd07raDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEP5cl97p6mPGbq1Hl3XdfrAvsrwYRU5K/L71g7Xv7k=;
 b=UjuzhzxHKPJX2Kd0chIANxOexmd+dXiTomn65Tfo4ZaPFqWp3aS32MUmOo9Y8MFmfk4fhklnfimjyb5F9x3OMFWLXGSnUHfzWpVWgPzAl1RuYCKxBIYS3YY1to+j+mPe3rCsAl3eg8yZ/XJUl8I4gSrChWcllS6PFEQFCiikums=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 18:07:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:07:42 +0000
Date:   Wed, 25 Oct 2023 14:07:38 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <ZTlZan240vG8HG/B@tissot.1015granger.net>
References: <20231025163006.GA8279@redhat.com>
 <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
 <20231025175435.GC29779@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025175435.GC29779@redhat.com>
X-ClientProxiedBy: CH0PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:610:e4::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 55202029-b3ef-4415-ce18-08dbd585483e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcjYPPS8TevSNBAGCuPpIQeB4kEj0uqkpBxmly7f89Z2+eJIAp5oGEV8kU57xsOfsXIKzeaQ5CSQSRG737c2AqCH/7LFWzZt1OZIgCkf4Uc8xMSw2+yf2vluCmNZRzi7aO08c8OIN8gdH3vPzN/z9Ph5yW1yCedYWOnsYJSYEUtqZqh/fYV2YM6JaFOREWmGBP/G0H89MfUj0VY4T93OfO70UefnQ3EMswD+e05Is7EXxKzdnH065fY0mV6q5BQe37GyZkkJOT8gD06WVja1RS+VitXkq6GRjN5yubK4EvnflfoRxRDk6GLlqzJ5OzseyCUd2b/mJVlA9T6S8tDcqsW91rSxKYcG8y1qtMVQugNQwtrmyzfW3eZhWnwjIpK6W7sUtHp9sHzhNTy7QPCRLAKDFwVHB9tzWoyCbRFhVKz1uGFNQsxP+7O1PuwdKQUttQiq8iGxDK2lAiWobtt6ISDPvkp1tTx6ucesMTHTobKaYcoytKItUNmxfd7vackZ5K/yj0eQ4EASCNYMi7NDFASS/WhAjex5lJO3M5KjP8S3bwPd9Kog7y87y3xRC8gs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(2906002)(38100700002)(316002)(66556008)(66476007)(66946007)(6666004)(6506007)(54906003)(478600001)(6486002)(9686003)(6512007)(83380400001)(86362001)(5660300002)(4326008)(8676002)(44832011)(8936002)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5MUC9fRPGvs1fVWuAlqx+2V33SvjrXGcsXV1V9tehDHMiAz4WhIBmRaJePe?=
 =?us-ascii?Q?D+8u09UpJG3SnONPsmYwYMWoM7hDzm2EaFEFpxFoAdT9R0u57+FncOALY2Qr?=
 =?us-ascii?Q?moAh5JwJSsDJwulLIvaicAi83kFjDgRGmMIuXe/LxD8/oPbwFJBMK1Obl0EP?=
 =?us-ascii?Q?bgiKAHfv0Qmq2x1gFRlgSHv+XMei+i/uU4w6EK/8f6p3DgDUcIezWuG9fNGS?=
 =?us-ascii?Q?xhJjv2XdMkUkgiN71zxAX486EEy06iZE7HGL/wvw2UCFd7E4QMU75T2Hpbco?=
 =?us-ascii?Q?mmmQdlOmkluw8s6E6VICyrxkuh+poOM32ff52fvrxZla85sNIzpCc2WHIfmk?=
 =?us-ascii?Q?VFmFJJUGcwxZ0QlN4bzJZjsMQVE9XMIB81fpfMIwp5yAnKI2gKVwUiNoBfo0?=
 =?us-ascii?Q?FMZsV5ngXnrOumPaUMrxBQsNCgay2m+28XiyNWra/j6zcCHenXI8OtOBMWgZ?=
 =?us-ascii?Q?ugPpcwKxY8Pt2CHx3q86gWf7MxioQWQDVcNU7IN4VgdQZOnRNUVeBM6rCBYx?=
 =?us-ascii?Q?jP6Tcazc0vQhnSlWrIPsq7r/s1HE2tUPB/ROQ3jj+ORWMhFGFKvGR4Wk4ecK?=
 =?us-ascii?Q?mbgFBKzI/CnzPHowqheE+Y+BKsFQkbLVnDQl9q51LK2cfY6c8uAB0lY8XIId?=
 =?us-ascii?Q?2uzzr5gpOH50yKipR9v4ZhyEvTq1is9uKJMGzmnLEoTtGD+gxSAtL4wm6HCT?=
 =?us-ascii?Q?4CdIjUJj5b5WGSqf1626YH9K2J8wf6bw5FW2aDUyg/ZDSloHDBphGbfe6rAo?=
 =?us-ascii?Q?s+ZBRBoM6ML5j/cFcb4pI4DIR6lhgHZi/dKQlBcycU2bOBj8EUTUioKz9w70?=
 =?us-ascii?Q?nW4NJfZjZvVZLtGNZz7ECnr9H0TO8k9/OblJLQs0aDJamiFBnxrZi44LAIzH?=
 =?us-ascii?Q?xmwaD07nduC+ET1d5IWF+/0n658ZmFzYsaUMVFHMuoSYcIFDTcpbmavMUbEw?=
 =?us-ascii?Q?ltRow5pOMdY3q8c0+bD0kKp65XmifuOM/ZvXDRNdGQ6Y15uhka8ahanaeeAh?=
 =?us-ascii?Q?nGRY/5OJ8SrKxMoj4sLqbZLQjIpQQPzEpZ34nQcIuxg3xYGNymVUXeDMhjp2?=
 =?us-ascii?Q?QB1jtRm9ekSuUDEObApowAur9L63gXU39K7UKZMOHVKfCQKhbFkSueSPyEOG?=
 =?us-ascii?Q?v92DPitXgxk6t45kLm+FZ5IecJ4e+AoWasrID6AKUX9MrVpdnd4TSbXIuG1l?=
 =?us-ascii?Q?oZpNY9s1mjaW8Llkf3pFBeohnSslef3uTrxRzYOOLxKAOiMIe4eTwx2vFmXf?=
 =?us-ascii?Q?z4dWs8t32Yygxw2ydvtT/54KFI4YCywwjHb0pRB1RfwAZBeB+aWEc6rwJvZP?=
 =?us-ascii?Q?u/XgTNdx6AkJwxMwEZFj5JO4H2lfFlZ/2E9UV/SlRAG/WE0EiuDUo6oQymf8?=
 =?us-ascii?Q?6EIkBBjkO+0pE5p8LJacJgrdXj7dOcCYB3driLfYYXiJVmIiG6qn5/9+LzNr?=
 =?us-ascii?Q?ETdELmf1REwzzfYh69EeNv99JK5dAyHkIDX9xWCINva0/U5BMg21u0Wupd/s?=
 =?us-ascii?Q?uaQj9cKEnDNwcwPrGAX2yK6PQjsf+0IM/GILRP8LQPAB8yPpC0xvbqsla6uC?=
 =?us-ascii?Q?8fwHH4vUrBabsLZDAH2I+IQKTc/KwzTSh+oUkqdgJJI4X286nQ9XL8OMiExY?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1vN236EmXeR9UtA2jdbtTjlAYs7LX+udqVdpLsJ63D6Pz9fZjLY2HlLG+KSw6hZLQecX+Ez8WrWMdnLcl+9+oTU/d6ExweL3BApGVK1pSbOhXu9bAJiCtkzr2ggUTkcQj9wDpOdthMbgUy1gbg7m/t63yCLNIWNTylWS4b02p6cMJ0x14d2eBZUoZu9O1PLrFkvLqIo0oA/8OsWnI860frSchgR0swfTW7ewtpbuDTSieFUDh3qsvZEGjzJzZYu9T/8hfOymQiDIVUJKvzZ2dlrVWcozk8fCzyyvpdxV7hKl5Ji4orTBXvAG2l2KVo2Uh941bnwAzDGPsv1jlkshumdXZUIPNnOhZ2MHhxa87ug3PqvJ3TTx7TW8nQVmNQrTlZCS89VSYW+y2xLfaZOMDKg8wJPra1VEaGDUOkZhhC66OJLJ0ewzSkySvHva+rCFfg526P5rcuvf6A/crkJWk/hbrLcHe1YTuHN6BC0l2DPTn9E8PSAHRvfbPrSocBwIeMWG7cnqp4V1lt3RXX4CBhMrWLoPUNVWW85i/ItmwOYKnU/YYK7qEghK7fX9lgwDml3SiajVOIoHDeCUXIu5C1wnMMnFTTAwW/38K8qipFtRrW0zBGT70TtOIgt3WC1unj7L95gKzPvGO9HET9rOsxuuQl5EpSd+r40/xZQQYnjTpz8pzf78tRetHCbPfiWAm/6G+/0zbkEG9akIsZmOsjIlMR6/+4Bc8n1ooi7dnV+JQMZrNyGToh7/k4JZWtGpUAO6sxKCbntRr7nwotsUu0x2fIPN/qzBz7G3ukvEls27iZQ5pelGGhP/3SKmUJyZURT9P8KEs2yUJKim2l9NSxlCZSZ7CadvG7VA8uookiOjG7wZyEg4ZAx4+cY9s0rWBxkMVd6fUQyYwGORH81xKQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55202029-b3ef-4415-ce18-08dbd585483e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:07:42.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /olJW03R1wTvUt1Ao+Pm/H75XeJq2886klXOZj9Zl4RNW9e+PhX12aYuJdkr/FzIfT2+1Z2hcoJmhxYDOz/Q4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250157
X-Proofpoint-GUID: VVj5Fj2TLGPE3RzooJcZxlDbomXMZiHV
X-Proofpoint-ORIG-GUID: VVj5Fj2TLGPE3RzooJcZxlDbomXMZiHV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 25, 2023 at 07:54:36PM +0200, Oleg Nesterov wrote:
> On 10/25, Chuck Lever wrote:
> >
> > > Another question is why we can't simply turn nn->writeverf into seqcount_t.
> > > I guess we can't because nfsd_reset_write_verifier() needs spin_lock() to
> > > serialise with itself, right?
> >
> > "reset" is supposed to be very rare operation. Using a lock in that
> > case is probably quite acceptable, as long as reading the verifier
> > is wait-free and guaranteed to be untorn.
> >
> > But a seqcount_t is only 32 bits.
> 
> Again, I don't understand you.
> 
> Once again, we can turn writeverf into seqcount_t, see the patch below.

The patch below does not turn "writeverf" into a seqcount_t, it
turns "writeverf_lock" into a seqcount_t. "writeverf" is an 8-byte
field, that's why I said "seqcount_t is only 32 bits" -- that is
not an adequate replacement for the 8-byte "writeverf" field.

Your original proposal made no sense. But I see now what you
would like to change.

I'm not familiar enough with these primitives to have a strong
opinion. What do you think would be the benefit?


> But this way nfsd_reset_write_verifier() can race with itself, no?

> Oleg
> ---
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ec49b200b797..3e2adf3eb15f 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -110,7 +110,7 @@ struct nfsd_net {
>  	bool nfsd_net_up;
>  	bool lockd_up;
>  
> -	seqlock_t writeverf_lock;
> +	seqcount_t writeverf_lock;
>  	unsigned char writeverf[8];
>  
>  	/*
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ed02fb88a36..6320491018f8 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1523,7 +1523,7 @@ static __net_init int nfsd_net_init(struct net *net)
>  	nn->nfsd4_minorversions = NULL;
>  	nfsd4_init_leases_net(nn);
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> -	seqlock_init(&nn->writeverf_lock);
> +	seqcount_init(&nn->writeverf_lock);
>  
>  	return 0;
>  
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..fc4e31411508 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
>   */
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
>  {
> -	int seq = 0;
> +	int seq;
>  
>  	do {
> -		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> +		seq = read_seqcount_begin(&nn->writeverf_lock);
>  		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> -	} while (need_seqretry(&nn->writeverf_lock, seq));
> -	done_seqretry(&nn->writeverf_lock, seq);
> +	} while (read_seqcount_retry(&nn->writeverf_lock, seq));
>  }
>  
>  static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
> @@ -397,9 +396,9 @@ static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
>   */
>  void nfsd_reset_write_verifier(struct nfsd_net *nn)
>  {
> -	write_seqlock(&nn->writeverf_lock);
> +	write_seqcount_begin(&nn->writeverf_lock);
>  	nfsd_reset_write_verifier_locked(nn);
> -	write_sequnlock(&nn->writeverf_lock);
> +	write_seqcount_end(&nn->writeverf_lock);
>  }
>  
>  /*
> 

-- 
Chuck Lever
