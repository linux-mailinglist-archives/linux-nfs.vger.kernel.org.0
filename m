Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D24B7DA41B
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Oct 2023 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjJ0Xen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 19:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJ0Xem (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 19:34:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DA1A6
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 16:34:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RLnM78006961;
        Fri, 27 Oct 2023 23:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mxmufOUzCdJco6h9cqMKSidgL/D1AVbXrePBJwi5m+w=;
 b=rhpViCCBlPcnKQextYZRcrhxHmoFjDGrUGsd114cwnb+uAVFCELp8LtCm3l9pbKa9imC
 1JmyA/WG0JJCmCXsLIhxsWNck674xTFVFh0im5IVmT3x523isbnf+vEuC2FqWTXaR6hw
 xg1H1fExz5v25vZI3+hP4eMihWw6oY6UExuLSdWyhKmEgb9MXevt7WTnUm/jnKNyqbjp
 az/WQv9tVFpdmQjIG9b2uBP6pDNVAhbWPelPG62qkczRcAjjMWLiRJVVkeFpJO0U7Kn/
 GCmUiC680Y4hfAvqd72INK1p04V9+MtzSsn52QUhmo9xm1Nm/XQCCzC2OHS2jtYKmRa9 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtbames-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 23:34:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RLPPOw020108;
        Fri, 27 Oct 2023 23:34:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqkv6j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 23:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9WB7cABWtpCQlzPnk3BTNdeiFQ5E3Is2kiQDZZVlqLNuH6YJr3lns646DXrOsamkA3tzh+baGJAAU6bYaRZY0ba47stu+zioBMSQ1G7/th9u5b0eORVeve63nDHIzeQBe0OENg/QBvuEc+CEJUHt6jsqXWPyNoh1QY1u4S8giJDyBinOOrNQQ6zpkqBn+p2uVjUgjhlUgxZr0E2xLYQprIYkAgaBqmJw7SWI2mzXyx5OvvjWpCiO8HI+MXUqNwvdEvYqeGe6WOuMfTKeCRcxnu0XnRQErUsnpENfIBY3Ypb0kZlxAZyWflrtae3P8Wp9+6oTm1anX/H9jPcLBJwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxmufOUzCdJco6h9cqMKSidgL/D1AVbXrePBJwi5m+w=;
 b=IJQIWGgIGQ4e7Ulb1mKDRBSDtITxQD56cr0Pyh6plFnBPi24E+Ts6upfnd6BgDLhWLjFrSLSKgaGz1P+vF8br+a8doYXhcGgdLaXiOE+P4LENKI/HG+UfeuJp1oacrNVfRP1wHN7x65pNJq1FCV4PPzqB42MB5Yb8A62qlQrOKMfNg+9CZiHtGiM5MObAfFtqJNVRyek5WTY9WaOBnMROgtdxvS0ngtVdKlHAevcdJVvT13xhDRhBfaQ2X/OuicIBJ/bqoKc7xNhqwiRTCM76AhGIg2pw4tgIljaW8sw1N1L0m0dCl3UUsaOzfIeaVwyILywrFjetUP0tTA6+1DRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxmufOUzCdJco6h9cqMKSidgL/D1AVbXrePBJwi5m+w=;
 b=FQqwCQvpPM/K0wH2DZSgLW+dCvMB8SP7Wlbkc3E9gnc4be98+AXdf619qmENItMT+rFaNcmduZCBHwh+h2wl2YP+PpbzHpO7Qh8ZwlWl3KEfZTO26Wiybm1mG4+Fxq9yKPf7mRsHdN4guISd+blR/jrLoeIUYESiKIFbetk70CM=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 23:34:28 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 23:34:28 +0000
Date:   Fri, 27 Oct 2023 19:34:24 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/6] support admin-revocation of v4 state
Message-ID: <ZTxJAElWAMiGtjF6@tissot.1015granger.net>
References: <20231027015613.26247-1-neilb@suse.de>
 <ZTvaxWodP4rKFkrm@tissot.1015granger.net>
 <169844461904.20306.4942454840443131694@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169844461904.20306.4942454840443131694@noble.neil.brown.name>
X-ClientProxiedBy: MW4PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:303:b7::33) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3f8945-01f7-448f-4a43-08dbd74542e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zX/fQ58g2Q3zc3dvdYBCsqe6YEuKqVqhOJCrp78GzJU6LtsfjJToilvnxy859dWtVhK/lNCAw23TBM9yRY0afyJI/ZH0Lr0RTdguTzmhnNyL2e+2dW6utwTUJXz+SvjMCf9qD3UUYQjdhe8zvVmNl/xIgYvTUvLkyq75S3mzGOQxmYyyG70C2/XDXVdOGmTXBueYGtXHTcb2qE8rdDpbA02oEckI6WC02y+bRQpDrtHY/rMZ07JdaSVuiV5Q/Ej2KKU7FahHDQxaM6kHQRvPfAHJt/m5ViG1gjLf4DbVCx9uWa9AhnCkITQkOkIhht09QsIV0wEXR7SDzSB//TDZXQp8lntCmD3Uzrdy/XbYGOQH30JalIAaKawgR6Brnx61lNN1pksPaKTcZoL5x7Tqihl6wD2jbUaYNBC7cwXuXUMyTyScXR1JVQLDy4RvxlyjLS2iYx4P/3eA6pA1+G1R0D7Un6RaeUEqwH6Gk5QOiQBTGqrIhSq5zEtpQcTWao/CIG86BRspcfAOavhar6CcjarO6vExG01fk2lqmLUuK3uCH9BWfdCiSv8W+tLNc8Jm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(478600001)(86362001)(316002)(6512007)(6916009)(66476007)(66946007)(38100700002)(66556008)(54906003)(6666004)(83380400001)(6486002)(44832011)(2906002)(4326008)(8676002)(8936002)(5660300002)(9686003)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QYtwEz2grOcZTSp/Fa+YHPDJUsYXLta6DkKo4v1qe7L1lhLX6SxVSUeuZNN0?=
 =?us-ascii?Q?YgPp8NL6KuqvfILIzPbpKwjVpMTJCJkdqxSybM7qLMhDXru+1lRQW/n53SjF?=
 =?us-ascii?Q?hHCw4CRhIqS4jHaTTjKOAMDPF4ZzIktYP0i3gaC37D0zWVc1JGExkk1rM0fq?=
 =?us-ascii?Q?Eb6LqzHm/FbFC+k+4gz6mWox9E6R/LS3egFNjyBy/EpLeqjqIBOajpbcpc2V?=
 =?us-ascii?Q?VqSkEe1noYufleSQimMay/mvOskrpEt4Ty5QftfVQB2jbAK3BBbmGRtmho7e?=
 =?us-ascii?Q?FcO5WeHqwPX1pw84dLExh883bqQ7NtHVGvScFLMsvj3Wp21c1lxAKvqHgU4t?=
 =?us-ascii?Q?FJ3JqRwk05D9IUJU19xq7h6sixcoh46ltvCWCBcO2CesPcmL+rnAwoOXawQ7?=
 =?us-ascii?Q?geu5KzalsvmCm/Wc73Zc+C6sx09qIkyyfZHwiz8fUwnaRuMzIblrzsF4zb6y?=
 =?us-ascii?Q?Z7+m2BeG7q6MgKqtW/6yDAD7FT/Y57jJRktv5zLjpGYo+MTN4UTGWp4LYrVf?=
 =?us-ascii?Q?z2bhGkWJU7RVmRkXB4JP47+52JWLxPHXwFsJPH+uiF3pRsLIPtIenbCiNQ/G?=
 =?us-ascii?Q?/g2s26tvRp7GHrd8EchK1fogoGIUgEoxOraC0wWzD6spfT40UHLnqZKqOpAM?=
 =?us-ascii?Q?BZxSNNxVqSUP9+YS4qCnnt7i/0RpESQApCfAe78JgRWAqkcSePQj6IGAKO6p?=
 =?us-ascii?Q?N4rFYDSr2lVq582Bul+UJq2WZz9beLD1MtLBj8nw5FY8YbEee9zEbSPzTPcO?=
 =?us-ascii?Q?inxE70Mt/lJ+2qi8TXX/tR/lO3iZz3sT/WzHCwVsskyiUKmz37jwn+2XDKdu?=
 =?us-ascii?Q?QQwKJaJ06x9LmT7fcCbESVqGS0EC8GpBN+Un5xJO5LMGvYsPCZLa/JiCwW33?=
 =?us-ascii?Q?O+TgAIOGiDhT5oS63pdCtRZ3hfnKYD2CtK/4DH6QaDoP+WnfUJVleiYXg1a9?=
 =?us-ascii?Q?keYnK+m9wnhlMnbFVuiRafLHyBDei2DAFwhK47YXjWYArMPG+AHR/YpF2ViT?=
 =?us-ascii?Q?QqvHpIFunOVVwUoZcixZgLZpWQ/mvRGT0yP+y+KQ6elqDEv9lnh/sJ5xqZXh?=
 =?us-ascii?Q?tWg8rtDtkYyXmPFhWZZ4bjLMsvGMMxlFhgqV6vOney1bi6uZnb9P2BQepiyK?=
 =?us-ascii?Q?3jj6wAQb4nxzSTEtg/iCOSM1oI3lQzuzNRzO5xCAOfIerfyajGGRWvqtxGVf?=
 =?us-ascii?Q?2R9nAOSsAYELNC3mJxi4uAmrJ90fS9FZTt1wJboD09ZQShX3wEclWljIqCQz?=
 =?us-ascii?Q?YPI/tJ6yjvYdBVFyI0wxgWHXf5BeQ86UWP4/b8bf5vLbv0NLT+guUgOuOhIj?=
 =?us-ascii?Q?37WxUfbK8ar3UAkkUKaaBdF/FpiiRV4CSVGsdtGtB5XzM3XKjmD6lE+iaXPE?=
 =?us-ascii?Q?Gi+iFW9QUwG4d+Av1opY1HI1S5g1Zh8Lbfp5sGkP0e6WpRXAT0lNA4hrt4Uk?=
 =?us-ascii?Q?QzxZ50/wz9qVyT0ICtrHBXNF1nIYkaWkkSiL9kMEnc5Hyo/pL3rutwgIZW3l?=
 =?us-ascii?Q?tVwntY5kbdrw5OEsd4a5+fSKe/qGvzgV/q0cAYV9q3kJlQTPsd5Zv92AkqXQ?=
 =?us-ascii?Q?eotUkcpJs3cDOgRpMktkgfqUqPPVjEKz1eFcPcLg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6CRTWsjvju5eEN+gKnUrgxMLBJvXk4P/dAxhxTrM9oCW2ufc12kW/DBY5geDdUgrDVh6aCMUdRGapo86otOBDOEBbF7AbRsip62KtWIyUr+oyR0mvf3GmKIjBB1JepQRyQYIj1wPikLojeePsuYIf8xUenD7yHSOv9OWNdC9pGEiyjjnSE/LaR7pk2wjk13pRKo/TQKXKgLLFXzdImmdm0QtnQ3YAept/bL9BQFllDrPDoWjFMM1PtQQ5fpXi2kr2DxFmcUCK88QprUA7ChCQ+QL3FhbOUvZ2W+bN1jEFuJDdmMSCx0s85mQecYGCaAoyhS6PPHW7pUIjLIPOgQQvNKKp0tBBrERUQWB/oB73Lb+zcXmgjY6WYTZefqpDmJwHdmJeydYimHPX7oGoM5ftys4lJaowCarEJldbQtlgcELdpJJnyKJuc+TrPNgjtivqrbtvwaUogjaS1+BdhxbPueF7kpz045v54RG/ZADkgVR8Yu7vdnODZxvZPErWco13rBmBACgybkav/aCdDHwnjmqH0BL2OtZRLkGb+GQh35WsGo/YUZxPGHnhvrAfzIBFdByTuC5FQl91g50oGRO0ODLIZCXbc+0VC9kkAcB0wBN+2x0xjvO1MQEumC8Z3Wyz8GKRr/92SEzZ7/ucCIPUYT0tHPtmKAPet7TjYrPop4lHaAsVFPXZU4IgQkAifQd+yq94bLGBjNr6069baN7Qfdbew8T5oEoVDImjOmcIW5lLgx/gUO39FyzHVhIl6IbgYRjgOQx8xFMbFSFYDB2d9Zle3vBoJo/YAHRAaGDNXKgTvU07wt16dtxbNHGZPc7AZv38k6yu6S94FJz7A32fEMIBuRt+Le3Gl2KMYYH3dfleDbCeooTEL3d7R3pbuIw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3f8945-01f7-448f-4a43-08dbd74542e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 23:34:28.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQinFDXmrLszqbJYsIRwvmLninoo3Wmi/AR+1jL6Y8Pu82PW7Y3N5ecOrlvzgyvXsQBX4mT0gAZqPZDbIraYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_22,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=523 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270202
X-Proofpoint-ORIG-GUID: c5AkhBFIvqcbi6C4E9DdDIKZwGOqXfA0
X-Proofpoint-GUID: c5AkhBFIvqcbi6C4E9DdDIKZwGOqXfA0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 28, 2023 at 09:10:19AM +1100, NeilBrown wrote:
> On Sat, 28 Oct 2023, Chuck Lever wrote:
> > On Fri, Oct 27, 2023 at 12:45:28PM +1100, NeilBrown wrote:
> > > This is a revised version of a patch set I sent over a year ago.
> > > It now supports v4.0 and has had more testing.
> > > 
> > > There are cirsumstances where an admin might need to unmount a
> > > filesystem that is NFS-exported and in active use, but does not want to
> > > stop the NFS server completely.  These are certainly unusual
> > > circumstance and doing this might negatively impact any clients acting
> > > on the filesystem, but the admin should be able to do this.
> > > 
> > > Currently this is quite possible for for NFSv3.  Unexporting the
> > > filesystem will ensure no new opens happen, and writing the path name to
> > > /proc/fs/nfsd/unlock_filesystem will ensure anly NLM locks held in the
> > > filesystem are released so that NFSD no longer prevents the filesystem
> > > from being unlocked.
> > > 
> > > It is not currently possible for NFSv4.  Writing to unlock_filesystem
> > > does not affect NFSv4, which is arguably a bug.  This series fixes the bug.
> > 
> > I agree that this is a good thing to do.
> > 
> > However, I'd like to migrate the "unlock_filesystem" functionality
> > to the nfsd netlink protocol first rather than adding this support
> > to /proc/fs/nfsd/. I don't believe that would be a difficult pre-
> > requisite to get through.
> > 
> > Does that seem sensible?
> 
> Not to me.
> 
> This is not new functionality - it is a fix for existing functionality
> which incorrectly ignores NFSv4.

It's arguable whether this counts as new functionality. I can see
both sides of that argument. For now let's agree to call it a fix,
and let's say it would therefore be appropriate for, say, an -rc
pull request (although I think it will land in nfsd-next for v6.8).

So, on first read through these patches, for some reason I had the
impression that you were adding another file under /proc/fs/nfsd.
That's what I would like to avoid at this point.

Changing the values that can appear in one of these files is an
area that is somewhat more grey. I'm willing to be flexible about
that for now.


> When you say "migrate" I hope you mean to add the "unlock_filesystem"
> functionality to netlink, but not remove it from /proc/fs/nfsd for
> several years at least.  I certainly wouldn't want to wait several
> (more) years for this to land.

Naturally. We are playing by the usual rules about kernel-user space
API deprecation. But there's always a fine line about whether an
about-to-be-deprecated API should get new functionality or even bug
fixes.


> However it lands, the interface that it used for NFSv3 should be the
> same as the interface that is used for NFSv4 and I think
> /proc/fs/nfsd/unlock_filesystem should be one such interface until (if
> ever) we discard the /proc/fs/nfsd filesystem.

Fair enough. It wasn't clear to me before that the new state types
described below will not be exposed through the existing
unlock_filesystem interface.

If Jeff agrees, I can pull this into v6.8.


> > > For NFSv4.1 and later code is straight forward.  We add new state types
> > > for admin-revoked state (open, lock, deleg) and change the type of any
> > > state on a filesystem - inavlidating any access and closing files as we
> > > go.  While there are any revoked states we report this to the client in
> > > the response to SEQUENCE requests, and it will check and free any states
> > > that need to be freed.
> > > 
> > > For NFSv4.0 it isn't quite so easy as there is no mechanism for the
> > > client to explicitly acknowledged admin-revoked states.  The approach
> > > this patchset takes is to discard NFSv4.0 admin-revoked states one
> > > lease-time after they were revoked, or immediately for a state that the
> > > client tryies to use and gets an "ADMIN_REVOKED" error for.  If the
> > > filestystem has been unmounted (as expected), the client will see STATE
> > > errors before it has a chance to see ADMIN_REVOKED errors, so most often
> > > the timeout will be how states are discarded.
> > > 
> > > NeilBrown
> > > 
> > >  [PATCH 1/6] nfsd: prepare for supporting admin-revocation of state
> > >  [PATCH 2/6] nfsd: allow admin-revoked state to appear in
> > >  [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
> > >  [PATCH 4/6] nfsd: allow lock state ids to be revoked and then freed
> > >  [PATCH 5/6] nfsd: allow open state ids to be revoked and then freed
> > >  [PATCH 6/6] nfsd: allow delegation state ids to be revoked and then
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever
