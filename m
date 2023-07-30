Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B676864D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jul 2023 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjG3P5k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjG3P5j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 11:57:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3610CE
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 08:57:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UAEQmn006597;
        Sun, 30 Jul 2023 15:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=HFmk/xGsvw/RLLgEwFFrVyNUxGRvbN1lGrEfrDcfQFw=;
 b=3opZeKQiFzExZZa9guc2Gh1WXe193pjoVdWEYQntXT5+Xlhufeome/0tQHmKLye/9fzQ
 4KjgXrmk199D9uvuSuavpBLa9Qh0y6beVAlHCgK3CjHNFiaAXxKlGXPuRB754ISHArwZ
 +mOA434rubnmZcBouqIT96c71fvCNS/Pg945iBHga5MBE+s/ewkFbj5szgu4mlxBd+rg
 3mYCBctIYtBpCEUFDVi9zCDdnhhIUcPyaEr5Knw6/Ci4KkFb3C5YdpB+wMJzPWGyXaBH
 UVIUTSsLrTrsmYiK3s2bSJ8XOom9M2RLEPXaLx5H5nZduQf3duCT8lDduAeMWK0HnNMY iQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc299xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 15:57:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UFW5NL033560;
        Sun, 30 Jul 2023 15:57:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s73kcms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 15:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyYWeeaZLhVnBZFLSszqx2Lb4MrsfRddFZGV6iEj+/vNuKq2wzL7/of1h+fl79OBpQBk6k08eBlneKlnQ6hhvRrMRW1qfPmk5P7kbF1Cr1m/R3J8+/fNyTkeLr5VkFzkD3EemeFjjGBmbPnv7RRE2GMOQIUnlslaa7ABn8atftT8AZa3FydqJfr7Md37FEuorLVj8d68SdUnlmq2Ho9hgrB3T88shh7Lbu/wXbBdArU9h3R5fNKOU0CmhjovmWGtgnXBITKmXNeQ2ijYPkrH4wJoO2eazK4wWcEPyZ7/uY11hqYZep2YH01dxvniyMPpa2MEDq44Kdu09SK11lS3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFmk/xGsvw/RLLgEwFFrVyNUxGRvbN1lGrEfrDcfQFw=;
 b=Hm228WG37jOcU4SRU4pFkrmE8tzp9ASQq41/ezc6L5f5+URUKWv0G1MV/8XQ9v1cPaSslDGIOgNEsSgUzeE7N2zsB2F07GwlDxAWHF5TdP/BjkgfjIEGKIqKRKiyRzrRl6/wBp9P2aDBSo2UnafuZlZXHTmx9XdS2cK2TgNjv0dAa5OiF6Da22ObhZyJqyBM9jgVEtS6SVh/khx2jcSLuB3R/do2OTMaX81OeUPZDCO7GCi1JbrT0To72/jReyVeOu7ZLdmERlLjtBZ6apK9MCPOAI7mkKv9gg+Y0ulHQchxq2ZFLKOsshvu3ZthLBbLqsYdmaaBK/IoLCj3Vc+8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFmk/xGsvw/RLLgEwFFrVyNUxGRvbN1lGrEfrDcfQFw=;
 b=Aff04d2goF2H1TZJn1vrFuoqfdY0p01nptEiOrWJJ3wDElRjFsjQWWz/h5p3DtcS8Gpf3udsxiXu98k5y78syP5XQPjCndWYbgmIJ+RbuFD3iOLRKOqrs0mzozIYPHxXo3OnOT1co1ENlGBxAX7xQ1iks/5d1GESnzUTqSqtkEo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 15:57:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 15:57:21 +0000
Date:   Sun, 30 Jul 2023 11:57:12 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/14] SUNRPC: change various server-side #defines to enum
Message-ID: <ZMaIWPyEm83GaS0q@tissot.1015granger.net>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228863.11075.8173252015139876869.stgit@noble.brown>
 <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>
X-ClientProxiedBy: CH2PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:610:58::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ad8117-480c-4a12-2e2b-08db9115a8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YHOmUBsjNuZ+4plMVYCvLfckL80yFDSp5LiZZCx6MReuUXL2cMe4vUxj689zDfBn+MDmGpJKXt0jbmE6z1HyAJ374r8a/4jqpXd3fA5jAQYlWmT1t44GffWsr8tv3RhZIAhuNI0h98Hwn3rXQVeUhDDM9nWxDETsey7Ru59S+SiZcaOqggahjcb+8brkwK0UYZy3RWtDMEsB292ekAxio0YdMjzTQucb/3rvNdLVcy051C2t5wpqoUZrVti4keAijxrLkexvuLXchIcDc0ME53bQoAFyKqZYF3vEBZlKyhPPB+Al8PMTgADAdqXMJ03600s4HrykOy8ntYOO4o8Hn6fPQ2qe53WwfiPRloIhLZQkYngh4PuCu9U/wcdGXwA8qXKohYcIrxlRiVY66ztdk58NFlVJXpCjO3wXDcJ4BES+hW7A9NRrDabgzJstvh4X7gUq3mRxus3MEjxLzrABvSp0M6PiWdpjKt2btAg07PjyVLruowjBZGnvGu63DAkcIo2KQVglk3vPIY9o43oYbXQC7c9ig+yinfa05vpTfT+XsM2L3N8WJZOmhAFMLWC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(9686003)(6512007)(6486002)(6506007)(26005)(83380400001)(186003)(44832011)(66946007)(66556008)(54906003)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8936002)(8676002)(38100700002)(2906002)(6666004)(66899021)(478600001)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fM1ftkufueTl8KTyHK4FtkEoy7CbyOaUwFJt4Ev4AtzzFUU5ef2YOZEop17P?=
 =?us-ascii?Q?U8Z/UvcNPiITZ5nydT9bQA48YSaj0LA07FD29G2/5l6no6ro0S/P/L3XD+MP?=
 =?us-ascii?Q?uZMnuS0ehDsmw+N9hsgeEGwxGhY0L87wCHL+Ix9lGGV1SynIGBQKzbE+l/YM?=
 =?us-ascii?Q?IoyU9MV8E0kurmz58FXesvbsD+n7h3AN94LqbcdAPXJLndMi7W4ajlGzA0oJ?=
 =?us-ascii?Q?qw75MFFqkhzCLAjKCnVdhSrbLAFtoqDVoVsP9nyA9cZ/3hZqMeAn07y57UUa?=
 =?us-ascii?Q?QilPiMc1zTnyFHDYbQldoiXeX+8bABj9XkekjYT1bURAStZ9vttSauhgAHZ5?=
 =?us-ascii?Q?w12FghQcIWgrmcZ11CgrrWlEwyiggkOPcV9YRsx02nH52Sg/OPezpz+oMd5f?=
 =?us-ascii?Q?mmRm0WXb7OZtt1SjJtKw4Tl/bR2xT8Kp3v/hfMhGykc6sEVMX6bysZgpetsD?=
 =?us-ascii?Q?PAnrUbopauOE9HKLObyfl9J660SrVqgk1bhXNsyqkLesfHj02f3xiSUcUsPR?=
 =?us-ascii?Q?ySkionZskJ/3FSj23iQ67oYNaR1LifMchhNo4wKeG+EtTTR5uGepPPa14WwR?=
 =?us-ascii?Q?qDRv7zbEXX+A67KzzXB7J8IsqhXWFHWJTYpu+ONjSE32H88z7HVCqnWJCeuP?=
 =?us-ascii?Q?UopkfLcYq/H7z1CO3LxhRpKllRcxsDQROmEk6db3iIgQ0MsQZzRTaLq2DspZ?=
 =?us-ascii?Q?KPMAT28n13zkMor/479LJooWRKRD9fH7+81ZsQyflzaLg9IqPRYVzTInEzwA?=
 =?us-ascii?Q?ZvbPhmZGvtJxVtAz/+NaVBFPofjUrCMMx7aWuMIq5hO+YwL+gryA5AfMkrGe?=
 =?us-ascii?Q?A00r1iBC8NtD+mUvHtioMXJXRG+zpX5cjQM4W2prOBF8Zz9fY93qs94ttiAL?=
 =?us-ascii?Q?+nX2K48ch77Dsf9IV9ZIi4JP0llCRpFt5fYYgjUhX9NUWunxW/arDznktSb2?=
 =?us-ascii?Q?mES9UoLD3vMhJ5qP0fqhPilsg0Od8/AOj5aqQ73734OjPZkg09vYDHvGBIGS?=
 =?us-ascii?Q?vW/mkb+JqTeu5NjQ87vtE2jCOZtKzFxe9kyNhgktlsuqd7m0q3ZktZXPT49U?=
 =?us-ascii?Q?bWoddz59z5NpcBc466NfrpA3k5JEN7dFQArRW1zWgSLqxYUCbUALEXtSjEDh?=
 =?us-ascii?Q?K7U+dhmrcUEruBKFe4f6Tq9euFfeG24a8pTqdOXPdrFl8Qw/qQ9Tl9jWXcuX?=
 =?us-ascii?Q?9OHADhPhEdj7t4e1LxZ3KOohUGl38Ez0nEBhaGcCt6MnVaRUDcB/WaDrRIB8?=
 =?us-ascii?Q?kjzkWY3b0GYNUmcStviCztd1TEuu6kg/zPdo2IcNtNgPmagOYMPMhquNgrEX?=
 =?us-ascii?Q?wlA0Fp2jsdGV6Lmrx2WNGAXEMQ0Y6wwS0FmN7LpNBrbDqlMusImvBGsHnNyZ?=
 =?us-ascii?Q?Fcn5d//vuKUfr4Yfvh356BG8vHXRyTpf+ATxMiABa/Bh7SXpNEIVBKt0Vh42?=
 =?us-ascii?Q?0R7DA9dettWYAOzk5IIlF0QWEe/jS38u1+0LW8pRDXgmzyskW+szY+E2Fbxz?=
 =?us-ascii?Q?/T+TxxnrD2wBbYi7mz6GuxbVjMi6Akymp/x3N0YmfMKq9RBWUwjpcvlUgjR9?=
 =?us-ascii?Q?j3RRQyRudMTM4f2gGG/VC9pg2XHKfSND7Wi3V+hu+3M4F0XkA9RH64WDMWKW?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ElnEVuldaLVn1p3QDELt5buxSoFSWoJsXeoPLRSSv2Om/417S8gZMyKJ8qenyxoyj7ygo0xMjXlRF7zDWu7b+bkI1/CFDiKsdWAufzvtHN2cxdFPDEmyhEC24QoAAqzPdTqXOX2RzPQcNbsXarWEQn1iimh2gDSQLIsZJl/mN9EnV2704/QzsigfoZp27qqm8EpXygxxjWSwY3HVnNsPjtaBEwsCm3u3WHCywVoEmZHezLJVGZJzeBQINGe8SOQ6Y+jSHZdNw8S7TYmHP2fnUWFjSUjfsLVKut3YvUefGbPZwGFqZoxMFZkKN0zYySoBd+ufCiKlaDluCgdrk120xzzvOqPasCnf2SjKZnZgv7c3Vr5AWn6XZp4X32n/9ZI53+gbkKVzJtK5P6TLJ9X8f7IVZaTVh0TzH3TpNNRYoQdT37V4IVCk98CaySdRJIJcpRGWQvvf6Z8zvBGFCW4UdFb3/Xj8JwmuYg/z+QAtsMC0ASyYcSjHx3kNHN5lFOMmtFO0M++213vPjOd8tpnPJ/QqASBQ1vDgP/hyqKm/acKrVZQjnB0UDnynOTixU5EyyMNnhZigeq7Od0xRyRoKttkvmp5RUVQh7Ovl+rxs/hFht3VsruKy+AklxDSojK5C4EjE/YQshcaylWhNrwBkEItvUoBACliuJQEV++eL7Xmk/D7CpQm2ydd8yksSJ7XkVsNwqDJSluCIyia6PmOY9mYMn9B/cidG4Yy3netBWqcHg8nUdX9xQTAs5Jm80pG80cijjSEIXswfrqsHMh+4MXTopepbTD6c09iHH/up7B2t7JZCS/kQIVdWOmrEPu0b
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ad8117-480c-4a12-2e2b-08db9115a8e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 15:57:21.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkgoGcKgOnd64epCghilGX4LBPxReSLfVpwa8+qRNC/7H3s3ViOvrENwltQXQPukruVE6+a9v8AU6Nbwb898Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307300147
X-Proofpoint-ORIG-GUID: ppoQaYasuDZhTzSnMp_Hwbot0G_W4IjX
X-Proofpoint-GUID: ppoQaYasuDZhTzSnMp_Hwbot0G_W4IjX
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 18, 2023 at 09:37:58AM -0400, Chuck Lever wrote:
> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> > When a sequence of numbers are needed for internal-use only, an enum is
> > typically best.  The sequence will inevitably need to be changed one
> > day, and having an enum means the developer doesn't need to think about
> > renumbering after insertion or deletion.  The patch will be easier to
> > review.
> 
> Last sentence needs to define the antecedant of "The patch".

I've changed the last sentence in the description to "Such patches
will be easier ..."

I've applied 1/5 through 5/5, with a few cosmetic changes, to the
SUNRPC threads topic branch. 6/6 needed more work:

I've split this into one patch for each new enum.

The XPT_ flags change needed TRACE_DEFINE_ENUM macros to make
show_svc_xprt_flags() work properly. Added.

The new enum for SVC_GARBAGE and friends... those aren't bit flags.
So I've made that a named enum so that it can be used for type-
checking function return values properly.

I dropped the hunk that changes XPRT_SOCK_CONNECTING and friends.
That should be submitted separately to Anna and Trond.

All this will appear in the nfsd repo later today.


> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/sunrpc/cache.h    |   11 +++++++----
> >  include/linux/sunrpc/svc.h      |   34 ++++++++++++++++++++--------------
> >  include/linux/sunrpc/svc_xprt.h |   39 +++++++++++++++++++++------------------
> >  include/linux/sunrpc/svcauth.h  |   29 ++++++++++++++++-------------
> >  include/linux/sunrpc/xprtsock.h |   25 +++++++++++++------------
> >  5 files changed, 77 insertions(+), 61 deletions(-)
> > 
> > diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> > index 518bd28f5ab8..3cc4f4f0c764 100644
> > --- a/include/linux/sunrpc/cache.h
> > +++ b/include/linux/sunrpc/cache.h
> > @@ -56,10 +56,13 @@ struct cache_head {
> >  	struct kref	ref;
> >  	unsigned long	flags;
> >  };
> > -#define	CACHE_VALID	0	/* Entry contains valid data */
> > -#define	CACHE_NEGATIVE	1	/* Negative entry - there is no match for the key */
> > -#define	CACHE_PENDING	2	/* An upcall has been sent but no reply received yet*/
> > -#define	CACHE_CLEANED	3	/* Entry has been cleaned from cache */
> > +/* cache_head.flags */
> > +enum {
> > +	CACHE_VALID,	/* Entry contains valid data */
> > +	CACHE_NEGATIVE,	/* Negative entry - there is no match for the key */
> > +	CACHE_PENDING,	/* An upcall has been sent but no reply received yet*/
> > +	CACHE_CLEANED,	/* Entry has been cleaned from cache */
> > +};
> 
> Weird comment of the day: Please use a double-tab before the comments
> to leave room for larger flag names in the future.
> 
> 
> >  #define	CACHE_NEW_EXPIRY 120	/* keep new things pending confirmation for 120 seconds */
> >  
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index f3df7f963653..83f31a09c853 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -31,7 +31,7 @@
> >   * node traffic on multi-node NUMA NFS servers.
> >   */
> >  struct svc_pool {
> > -	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
> > +	unsigned int		sp_id;		/* pool id; also node id on NUMA */
> >  	spinlock_t		sp_lock;	/* protects all fields */
> >  	struct list_head	sp_sockets;	/* pending sockets */
> >  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> > @@ -44,12 +44,15 @@ struct svc_pool {
> >  	struct percpu_counter	sp_threads_starved;
> >  	struct percpu_counter	sp_threads_no_work;
> >  
> > -#define	SP_TASK_PENDING		(0)		/* still work to do even if no
> > -						 * xprt is queued. */
> > -#define SP_CONGESTED		(1)
> >  	unsigned long		sp_flags;
> >  } ____cacheline_aligned_in_smp;
> >  
> > +/* bits for sp_flags */
> > +enum {
> > +	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
> > +	SP_CONGESTED,		/* all threads are busy, none idle */
> > +};
> > +
> >  /*
> >   * RPC service.
> >   *
> > @@ -232,16 +235,6 @@ struct svc_rqst {
> >  	u32			rq_proc;	/* procedure number */
> >  	u32			rq_prot;	/* IP protocol */
> >  	int			rq_cachetype;	/* catering to nfsd */
> > -#define	RQ_SECURE	(0)			/* secure port */
> > -#define	RQ_LOCAL	(1)			/* local request */
> > -#define	RQ_USEDEFERRAL	(2)			/* use deferral */
> > -#define	RQ_DROPME	(3)			/* drop current reply */
> > -#define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
> > -						 * to prevent encrypting page
> > -						 * cache pages */
> > -#define	RQ_VICTIM	(5)			/* about to be shut down */
> > -#define	RQ_BUSY		(6)			/* request is busy */
> > -#define	RQ_DATA		(7)			/* request has data */
> >  	unsigned long		rq_flags;	/* flags field */
> >  	ktime_t			rq_qtime;	/* enqueue time */
> >  
> > @@ -272,6 +265,19 @@ struct svc_rqst {
> >  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> >  };
> >  
> > +/* bits for rq_flags */
> > +enum {
> > +	RQ_SECURE,	/* secure port */
> > +	RQ_LOCAL,	/* local request */
> > +	RQ_USEDEFERRAL,	/* use deferral */
> > +	RQ_DROPME,	/* drop current reply */
> > +	RQ_SPLICE_OK,	/* turned off in gss privacy to prevent encrypting page
> > +			 * cache pages */
> > +	RQ_VICTIM,	/* about to be shut down */
> > +	RQ_BUSY,	/* request is busy */
> > +	RQ_DATA,	/* request has data */
> > +};
> > +
> 
> Also here -- two tab stops instead of one.
> 
> 
> >  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> >  
> >  /*
> > diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> > index a6b12631db21..af383d0349b3 100644
> > --- a/include/linux/sunrpc/svc_xprt.h
> > +++ b/include/linux/sunrpc/svc_xprt.h
> > @@ -56,26 +56,9 @@ struct svc_xprt {
> >  	struct list_head	xpt_list;
> >  	struct list_head	xpt_ready;
> >  	unsigned long		xpt_flags;
> > -#define	XPT_BUSY	0		/* enqueued/receiving */
> > -#define	XPT_CONN	1		/* conn pending */
> > -#define	XPT_CLOSE	2		/* dead or dying */
> > -#define	XPT_DATA	3		/* data pending */
> > -#define	XPT_TEMP	4		/* connected transport */
> > -#define	XPT_DEAD	6		/* transport closed */
> > -#define	XPT_CHNGBUF	7		/* need to change snd/rcv buf sizes */
> > -#define	XPT_DEFERRED	8		/* deferred request pending */
> > -#define	XPT_OLD		9		/* used for xprt aging mark+sweep */
> > -#define XPT_LISTENER	10		/* listening endpoint */
> > -#define XPT_CACHE_AUTH	11		/* cache auth info */
> > -#define XPT_LOCAL	12		/* connection from loopback interface */
> > -#define XPT_KILL_TEMP   13		/* call xpo_kill_temp_xprt before closing */
> > -#define XPT_CONG_CTRL	14		/* has congestion control */
> > -#define XPT_HANDSHAKE	15		/* xprt requests a handshake */
> > -#define XPT_TLS_SESSION	16		/* transport-layer security established */
> > -#define XPT_PEER_AUTH	17		/* peer has been authenticated */
> >  
> >  	struct svc_serv		*xpt_server;	/* service for transport */
> > -	atomic_t    	    	xpt_reserved;	/* space on outq that is rsvd */
> > +	atomic_t		xpt_reserved;	/* space on outq that is rsvd */
> >  	atomic_t		xpt_nr_rqsts;	/* Number of requests */
> >  	struct mutex		xpt_mutex;	/* to serialize sending data */
> >  	spinlock_t		xpt_lock;	/* protects sk_deferred
> > @@ -96,6 +79,26 @@ struct svc_xprt {
> >  	struct rpc_xprt		*xpt_bc_xprt;	/* NFSv4.1 backchannel */
> >  	struct rpc_xprt_switch	*xpt_bc_xps;	/* NFSv4.1 backchannel */
> >  };
> > +/* flag bits for xpt_flags */
> > +enum {
> > +	XPT_BUSY,		/* enqueued/receiving */
> > +	XPT_CONN,		/* conn pending */
> > +	XPT_CLOSE,		/* dead or dying */
> > +	XPT_DATA,		/* data pending */
> > +	XPT_TEMP,		/* connected transport */
> > +	XPT_DEAD,		/* transport closed */
> > +	XPT_CHNGBUF,		/* need to change snd/rcv buf sizes */
> > +	XPT_DEFERRED,		/* deferred request pending */
> > +	XPT_OLD,		/* used for xprt aging mark+sweep */
> > +	XPT_LISTENER,		/* listening endpoint */
> > +	XPT_CACHE_AUTH,		/* cache auth info */
> > +	XPT_LOCAL,		/* connection from loopback interface */
> > +	XPT_KILL_TEMP,		/* call xpo_kill_temp_xprt before closing */
> > +	XPT_CONG_CTRL,		/* has congestion control */
> > +	XPT_HANDSHAKE,		/* xprt requests a handshake */
> > +	XPT_TLS_SESSION,	/* transport-layer security established */
> > +	XPT_PEER_AUTH,		/* peer has been authenticated */
> > +};
> >  
> >  static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u)
> >  {
> > diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
> > index 6d9cc9080aca..8d1d0d0721d2 100644
> > --- a/include/linux/sunrpc/svcauth.h
> > +++ b/include/linux/sunrpc/svcauth.h
> > @@ -133,19 +133,22 @@ struct auth_ops {
> >  	int	(*set_client)(struct svc_rqst *rq);
> >  };
> >  
> > -#define	SVC_GARBAGE	1
> > -#define	SVC_SYSERR	2
> > -#define	SVC_VALID	3
> > -#define	SVC_NEGATIVE	4
> > -#define	SVC_OK		5
> > -#define	SVC_DROP	6
> > -#define	SVC_CLOSE	7	/* Like SVC_DROP, but request is definitely
> > -				 * lost so if there is a tcp connection, it
> > -				 * should be closed
> > -				 */
> > -#define	SVC_DENIED	8
> > -#define	SVC_PENDING	9
> > -#define	SVC_COMPLETE	10
> > +/*return values for svc functions that analyse request */
> > +enum {
> > +	SVC_GARBAGE,
> > +	SVC_SYSERR,
> > +	SVC_VALID,
> > +	SVC_NEGATIVE,
> > +	SVC_OK,
> > +	SVC_DROP,
> > +	SVC_CLOSE,	/* Like SVC_DROP, but request is definitely
> > +			 * lost so if there is a tcp connection, it
> > +			 * should be closed
> > +			 */
> > +	SVC_DENIED,
> > +	SVC_PENDING,
> > +	SVC_COMPLETE,
> > +};
> >  
> >  struct svc_xprt;
> >  
> > diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
> > index 700a1e6c047c..1ed2f446010b 100644
> > --- a/include/linux/sunrpc/xprtsock.h
> > +++ b/include/linux/sunrpc/xprtsock.h
> > @@ -81,17 +81,18 @@ struct sock_xprt {
> >  };
> >  
> >  /*
> > - * TCP RPC flags
> > + * TCP RPC flags in ->sock_state
> >   */
> > -#define XPRT_SOCK_CONNECTING	1U
> > -#define XPRT_SOCK_DATA_READY	(2)
> > -#define XPRT_SOCK_UPD_TIMEOUT	(3)
> > -#define XPRT_SOCK_WAKE_ERROR	(4)
> > -#define XPRT_SOCK_WAKE_WRITE	(5)
> > -#define XPRT_SOCK_WAKE_PENDING	(6)
> > -#define XPRT_SOCK_WAKE_DISCONNECT	(7)
> > -#define XPRT_SOCK_CONNECT_SENT	(8)
> > -#define XPRT_SOCK_NOSPACE	(9)
> > -#define XPRT_SOCK_IGNORE_RECV	(10)
> > -
> > +enum {
> > +	XPRT_SOCK_CONNECTING,
> > +	XPRT_SOCK_DATA_READY,
> > +	XPRT_SOCK_UPD_TIMEOUT,
> > +	XPRT_SOCK_WAKE_ERROR,
> > +	XPRT_SOCK_WAKE_WRITE,
> > +	XPRT_SOCK_WAKE_PENDING,
> > +	XPRT_SOCK_WAKE_DISCONNECT,
> > +	XPRT_SOCK_CONNECT_SENT,
> > +	XPRT_SOCK_NOSPACE,
> > +	XPRT_SOCK_IGNORE_RECV,
> > +};
> >  #endif /* _LINUX_SUNRPC_XPRTSOCK_H */
> > 
> > 
> 
> Let's not change client-side code in this patch. Please split this
> hunk out and send it to Trond and Anna separately.
> 

-- 
Chuck Lever
