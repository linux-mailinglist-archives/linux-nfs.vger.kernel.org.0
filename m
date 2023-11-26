Return-Path: <linux-nfs+bounces-80-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5DC7F94C8
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34FEB20C61
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A785F4E2;
	Sun, 26 Nov 2023 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bKADzyRH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YuSGSNN2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A794F0
	for <linux-nfs@vger.kernel.org>; Sun, 26 Nov 2023 10:08:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQHb4LQ008658;
	Sun, 26 Nov 2023 18:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=t7YWejCxpjIHuv1jSTrE8ZG7aJKYJ5OsnhK6Jw9JBvg=;
 b=bKADzyRHk1kWw3TyZmINFwqdYqu/fCdncS6mQV2Dvq1h6e5VbAHAI4gaLfcP63PYhPnL
 V5YPcFXIqRgip90ONypjuv0DSWHD5op521dAyfk2ghetLL7/R/7obl0rRoSNyE9H9eO5
 +vvRAjabir2s6mp4yR2maXFEofkNkmUHcl7A2JdeHrAdwvt+DPTwOHhhaB6RJwTwv4ok
 RnxJ4aBwEl0zVzfKOnyBkwPZy00eQ94SldCYc+3IYDN+A7E8F8zndvKI3LbZlgbJ2kcC
 24kIqjA2bRJ3WgQXgib+MO+r+dOSp6nuldcIXZCWVJEZrCgpqko7wRzN14H8yUFTI7vH aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2hhyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 18:07:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQGgM2M001365;
	Sun, 26 Nov 2023 18:07:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7can141-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 18:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7VkRk9yTQiooWbRHrZ5n7EfkFEdaEaMOFoPOy0TBac9FFAfw1y3TMcQGBFDyQx5baIDpnqQNNB2JfXU42RCeDkppuwDF1ic9sZsEB2LWHRDEJ6usJPrL/btYEkjpRBi9erpQjxNEfmwcc9L8SevRErZGqNxkrqyqguk1BCK3YB3uKbCwf2TymBEb/wxNYvjTPhmyQkfojdadcV9J86R2vg7/Gim414M6OWTkTrGKpiwbT55EAjFAOTkAfCMpAQ4uOiK6wdnuutne/UGUlPi1oBnHkOVSiwZ5OmH/JFfDBc26C7PfPr6+EyJzVGKOe5T4tfti0GtKlvSUi8wqd5wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7YWejCxpjIHuv1jSTrE8ZG7aJKYJ5OsnhK6Jw9JBvg=;
 b=aooWmJAhTR0igJij/MRy36kYygaU9G+4XVB5/rE8CYIngsOmGSUjvO6kG/wyNVmE8+2jBdvx8598aU1ooi/nse2xTmNE3KRmlOLP7BYWgwOo2eEylt0AH/4Y/Le9lrqofpRu2k5PH7hfbjIbf2PD8u9sIjXceJUWh5zEmX6mPWNEiuPvOLqUlafmonkmrGwJQ/NkPdk57SmnH29Gy3nUZCV1EVamP55OP4f/GCT5RSj7al6UAyahk+clcWhTiNzKYpZG3m+5WbUYoUJZvTiuH9evc4XtMqulFmnSBG8GvIzGYYFU8ilbklNQdBlFPA1v1qKHupm53sZJOh9q2brWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7YWejCxpjIHuv1jSTrE8ZG7aJKYJ5OsnhK6Jw9JBvg=;
 b=YuSGSNN2VfTxoOzUaqagy4RScpF1+OdLDvczBTfhIS/7SvEvSahoAJlQt3xvoOIOqy7RMeEdU7mcSO2KLsPkQZbKNg3eW+Qfn1CVOgYZA1/e4FixRJ3hAj1fZnKVLIatnXdoCgSqm05zMZsuPdGSH9fb4lmZ9vVBMHz94tpeQhc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 18:07:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 18:07:52 +0000
Date: Sun, 26 Nov 2023 13:07:49 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 07/11] nfsd: allow admin-revoked NFSv4.0 state to be
 freed.
Message-ID: <ZWOJdVwsOI/IKZVp@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>
 <20231124002925.1816-8-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124002925.1816-8-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:b0::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: 4243a20e-a03c-44f7-b763-08dbeeaa9b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bMMrNY73QqPlAQMsdNKhA4Cb6a9O3wZx6cZXIAKW/rB0GpaQ75UlVCUv7+fNC/3LHMu5noauRbvjvkWnNpUCNsA/tYi3VLa0/VJ7+GAF5prbEmLCqEJ9uZKfhyb3QaVmTLvGGWZvWP+AdOAyQPxtyfA73fK7FFZ3Hi8wVEybgtX3Oj9m+9mpbYjDJ+lAGHzMGqSLovOWDDJvcgBJPtj/3HSvm7sfxKR2sCpE9rcuoEoVi4HD+ZU5i3oFi0sTXWvtjN24MpmPccnYXKgtv9htBrPSGPmJqozpAsAyMugFgNx46TdKCkV9zpuF55j+UKmjhO7jsZoUzlbpifzyA1K6dFYgwD0INQGXi+UUMkVJN4Bxc3HOHYx9tihhbp+ihadU+V6wqPpPFqtg79J+gDts+S1AYnBZXNj7ruvmXAe8GaczbnNh71yNgYK7u1gaj+RJDQlHivCf+0HEgoeuXfYnegNJ82zuKbDe57EQZG7Cz6RhnW7BcLDNKTJgCt1mTZprKUW00ffYX25f8YS8csj5igDYAdaEkcDEjr+U6YBwXG8BLAZgQJw+5n/9I4Lr5a4M
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(6506007)(6666004)(9686003)(6512007)(8936002)(4326008)(8676002)(44832011)(86362001)(5660300002)(478600001)(6486002)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(38100700002)(83380400001)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aU4hpzqvHJ1bzLgwkAu0CCJRvJd4j4+TMGLcri7E/QI62rei7by7RwUm3Nz9?=
 =?us-ascii?Q?Z8MrbhPrSECoMiFdAnQfUaOrga1AHmh2Xnt8GxJgcYy7YKicu8s5GqlfzDF7?=
 =?us-ascii?Q?VlzUfM5RhsPDH+V2GPeMr90Pkv8A2LBo2VgLB5xc/PaV1+9b/HmipHPSp4Qh?=
 =?us-ascii?Q?84ERMkiF6PjLOlgPuWbDjqtrS2buuJLnlqwsOzxZctVfsM6Q7rYH3yRgjCgn?=
 =?us-ascii?Q?FxKYzsxE1xSXPWysGuzkGXKWaoBwoEpQllUH52ZL6fIKBCx2S6GzRQmlOPQb?=
 =?us-ascii?Q?oWKe2bq5s10LofKYWrSqtkfG5QIDNqTnMN/WZiF1JhRgGBhKcsWP6GIvQuJO?=
 =?us-ascii?Q?cgx6u0KfcwMRxjS/NpYU+JLrus+a60CbR+PpLwNEo+oOYzZKq/3ZqNhp8U8A?=
 =?us-ascii?Q?Dm8lQM3gE270mqZggTVChCsLvmAYsN+ukqbiAycxMWWDTb1j1oneFh1WJvCB?=
 =?us-ascii?Q?vtYrxbnyqNfaxjQTpABpyl04KcnMWF/6BIWEO0LTgAyBLtlNH4FqDtHtl/N9?=
 =?us-ascii?Q?bnsSOoPynXkbsBkhlDAQ7V5RlGqnleGxReCfMsPdsNMzZNzOEeSO84JWtvxr?=
 =?us-ascii?Q?QJQ4KIIM1B674UoWEOcFT6ducMQ5Z7XFxMQS2lUrM6zt79n/BA+fORU6RUGH?=
 =?us-ascii?Q?cRYoRFGs7BZoVr3hGGhLM6umod9uUrNAfUBXcgH4LOjR2Q5sAYqFQx7W6o5g?=
 =?us-ascii?Q?Y4chZZYIeSzKrnP7yfv9g2atg7lk1hWEpZfIX5wc0KXMYNhT65YbBceHXEa5?=
 =?us-ascii?Q?qHjrgzLeezSvHdWmje3vswg1RzZ3XafymChC44a+BwyMOaRlv86J6iWbvtBZ?=
 =?us-ascii?Q?g+y1wchJy1nsy40O37IADf1tMu99zsL5GNRD7lQhDzv5++4750+NDbs02pTJ?=
 =?us-ascii?Q?5G6IGslzayTwHXxjSmQpwKsVkkJHGRlM77uw21f/ZaWtDcdXPnGQH9Q51q+L?=
 =?us-ascii?Q?5ZdFipcnn3v2BzKPiphJWbuIN06CmNxF/V9KMBQ6j3ute3+senJ3IMxxKj9/?=
 =?us-ascii?Q?Fcrpm4+mWQjdvkHxU5QXlT0o3YG/SSlnytTlHAXq6hPIHhua0lAc/UhMQVJX?=
 =?us-ascii?Q?r7bB3EnSBthpVY9vAN12iJodiRicymR6Crg6K5RFypuiBi1JVF7Om0a28buS?=
 =?us-ascii?Q?RmJC+eRgaYzcPyJDKSDIrFRkNhO+r4FA723nHROB030xFPFem2XrFE6lRWIg?=
 =?us-ascii?Q?qs3nyOh/uKtmzuifpmjP2B7u3lrInJQ0aXg5wA1BdyMZ6mOR1d8B1ErqAw0/?=
 =?us-ascii?Q?rtl5lNGOHLTiv0TIXcpDcqVyoFFGN67Va4DyZLDlHPVfG4dj//XOYD4hFlJY?=
 =?us-ascii?Q?iL0EuoRlKOhcSf4geO5Wf24vy6zp/Acseu4lUJLG+Fw694S3CaE/6flO5lPA?=
 =?us-ascii?Q?c3QTi1SRAsh/l5qeaOl9uqUFlskMTQjM/XwOGneMfVklnl0ny/Gp2Q/ZbUXZ?=
 =?us-ascii?Q?plPiWCXiZCfJD4QVXNLv/xe9gJCn+2klq1pu6QH5bGoryqC6fMcoIYS8tZOv?=
 =?us-ascii?Q?YbWzSJn0mc258QlWaHOHMQUo3IFUj+WQ3++KH/g12F345Dc4nZVoWgo191LD?=
 =?us-ascii?Q?xpbkQtFnlp5yRdnpHhb8eQO6AMty1AJr5m8lXXQmFHlimELMxrVl4O4Lfqnz?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8NfZcQWSJG5qoHJFGVJuke8VgckfpUM3RSYRR+Bk7hz4fL+iB7MdftoYQRCLsstdQ5H9CrtuCcd0qA1FkC7yAzqw/m3fF/dRk6MC6o0VF8Z2G9Qldrfu1dqOvxfWHt4DrL7ytfPEEL3cywOcnE3yQI/y0FG2htQMWsnEBiQR+wjAi8eB6DjGPsK0uaq1920sHe1JzFgqVzV65uxswR7yfOzCeFovYkJk2+ref7Fqq6xMA+2tGNE7WCPeUf3xheloji2THx1XdsEwgkAHTyTooMkOS+PYqV/OOJL6Kib7geMe52N24i90ZQ7dyl3ZA4+eA85bZHc72gUlk1tjsJOqbc39sD6EH67WP1F/hWKcmDSQWvUwURV5IVq+PZrqd/487RL0oD/4sWvDT918w2fe8XlTqwpKETyzAORcAHAhmW2kqtNC5YSi5tD8HLS5c7JvwRE1Hu72ylAG5Gt6/aKqhjaNvgfPMxBT4IOJFlBlsKqWTDTVJLA9eEI5JffR+tgoChOzrGakwfrd6w5FkaqQUTbVXuSHwyLFG8kc0tlTtEZN/I92PPws23NbHzzerqSJy0n+ZuJMqaG4I3nNCuPo3rsRfuLOCpRvEaL4zGvcijBIGNngGUTMGKuqR8qI585YYFDSSKFGAdIP5FJxv3mW0ZTFyfmHNphSHy+nimUS/TsHauG39NPwFLvDp7PZfFZNY2I+nhmodldot8ZeeogMpCdyUVM/mrHOl8T70ghkMSatI2rT5u+HoHksyfvM69SrHJVKQh5AVwgv++f1keFKaNSq1Nd07AZi65QJwa2GLseaA4YiQLdNgzEUKXG/mMImW2CHTY9fTEMxdh0nr1W6d7I1KxMWICsErjQeK+xS2h7gvOqhCJoWJpe4WVTQI4AF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4243a20e-a03c-44f7-b763-08dbeeaa9b80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 18:07:52.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsgcaR9T1DY/1JaylKu67KTF14lYg0j1CO62PpcQOze7CLKOhS9ND+52HlDDmCMzE2uQvv0E57h+mO2h7WgVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_17,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311260134
X-Proofpoint-GUID: bRHboKnUCUl4GO_zoJiyywSXjA72RGpz
X-Proofpoint-ORIG-GUID: bRHboKnUCUl4GO_zoJiyywSXjA72RGpz

On Fri, Nov 24, 2023 at 11:28:42AM +1100, NeilBrown wrote:
> For NFSv4.1 and later the client easily discovers if there is any
> admin-revoked state and will then find and explicitly free it.
> 
> For NFSv4.0 there is no such mechanism.  The client can only find that
> state is admin-revoked if it tries to use that state, and there is no
> way for it to explicitly free the state.  So the server must hold on to
> the stateid (at least) for an indefinite amount of time.  A
> RELEASE_LOCKOWNER request might justify forgetting some of these
> stateids, as would the whole clients lease lapsing, but these are not
> reliable.
> 
> This patch takes two approaches.
> 
> Whenever a client uses an revoked stateid, that stateid is then
> discarded and will not be recognised again.  This might confuse a client
> which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
> all, but should mostly work.  Hopefully one error will lead to other
> resources being closed (e.g.  process exits), which will result in more
> stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.
> 
> Also, any admin-revoked stateids that have been that way for more than
> one lease time are periodically revoke.
> 
> No actual freeing of state happens in this patch.  That will come in
> future patches which handle the different sorts of revoked state.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/netns.h     |  4 ++
>  fs/nfsd/nfs4state.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ab303a8b77d5..7458f672b33e 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -197,6 +197,10 @@ struct nfsd_net {
>  	atomic_t		nfsd_courtesy_clients;
>  	struct shrinker		*nfsd_client_shrinker;
>  	struct work_struct	nfsd_shrinker_work;
> +
> +	/* last time an admin-revoke happened for NFSv4.0 */
> +	time64_t		nfs40_last_revoke;
> +
>  };
>  
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 52e680235afe..c57f2ff954cb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1724,6 +1724,14 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>  				}
>  				nfs4_put_stid(stid);
>  				spin_lock(&nn->client_lock);
> +				if (clp->cl_minorversion == 0)
> +					/* Allow cleanup after a lease period.
> +					 * store_release ensures cleanup will
> +					 * see any newly revoked states if it
> +					 * sees the time updated.
> +					 */
> +					nn->nfs40_last_revoke =
> +						ktime_get_boottime_seconds();
>  				goto retry;
>  			}
>  		}
> @@ -4648,6 +4656,39 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
>  	return ret;
>  }
>  
> +static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
> +{
> +	struct nfs4_client *cl = s->sc_client;
> +
> +	switch (s->sc_type) {
> +	default:
> +		spin_unlock(&cl->cl_lock);
> +	}
> +}

I'm not in love with unlocking cl_lock inside nfsd_drop_revoked_stid,
but I understand why it's necessary. How about:

static void nfsd4_drop_revoked_stid_unlock(struct nfs4_client *cl,
					   struct nfs4_stid *s)
	__releases(&cl->cl_lock)
{
	....


> +
> +static void nfs40_drop_revoked_stid(struct nfs4_client *cl,
> +				    stateid_t *stid)
> +{
> +	/* NFSv4.0 has no way for the client to tell the server
> +	 * that it can forget an admin-revoked stateid.
> +	 * So we keep it around until the first time that the
> +	 * client uses it, and drop it the first time
> +	 * nfserr_admin_revoked is returned.
> +	 * For v4.1 and later we wait until explicitly told
> +	 * to free the stateid.
> +	 */
> +	if (cl->cl_minorversion == 0) {
> +		struct nfs4_stid *st;
> +
> +		spin_lock(&cl->cl_lock);
> +		st = find_stateid_locked(cl, stid);
> +		if (st)
> +			nfsd_drop_revoked_stid(st);
> +		else
> +			spin_unlock(&cl->cl_lock);
> +	}
> +}
> +
>  static __be32
>  nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
> @@ -4670,6 +4711,10 @@ nfsd4_lock_ol_stateid(struct nfs4_ol_stateid *stp)
>  
>  	mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
>  	ret = nfsd4_verify_open_stid(&stp->st_stid);
> +	if (ret == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(stp->st_stid.sc_client,
> +					&stp->st_stid.sc_stateid);
> +
>  	if (ret != nfs_ok)
>  		mutex_unlock(&stp->st_mutex);
>  	return ret;
> @@ -5253,6 +5298,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
>  	}
>  	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
> +		nfs40_drop_revoked_stid(cl, &open->op_delegate_stateid);
>  		status = nfserr_deleg_revoked;
>  		goto out;
>  	}
> @@ -6251,6 +6297,43 @@ nfs4_process_client_reaplist(struct list_head *reaplist)
>  	}
>  }
>  
> +static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
> +				      struct laundry_time *lt)
> +{
> +	struct nfs4_client *clp;
> +
> +	spin_lock(&nn->client_lock);
> +	if (nn->nfs40_last_revoke == 0 ||
> +	    nn->nfs40_last_revoke > lt->cutoff) {
> +		spin_unlock(&nn->client_lock);
> +		return;
> +	}
> +	nn->nfs40_last_revoke = 0;
> +
> +retry:
> +	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> +		unsigned long id, tmp;
> +		struct nfs4_stid *stid;
> +
> +		if (atomic_read(&clp->cl_admin_revoked) == 0)
> +			continue;
> +
> +		spin_lock(&clp->cl_lock);
> +		idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> +			if (stid->sc_status & NFS4_STID_ADMIN_REVOKED) {
> +				refcount_inc(&stid->sc_count);
> +				spin_unlock(&nn->client_lock);
> +				/* this function drops ->cl_lock */
> +				nfsd_drop_revoked_stid(stid);
> +				nfs4_put_stid(stid);
> +				spin_lock(&nn->client_lock);
> +				goto retry;
> +			}
> +		spin_unlock(&clp->cl_lock);
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -6284,6 +6367,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>  	nfs4_process_client_reaplist(&reaplist);
>  
> +	nfs40_clean_admin_revoked(nn, &lt);
> +
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> @@ -6502,6 +6587,9 @@ static __be32 nfsd4_stid_check_stateid_generation(stateid_t *in, struct nfs4_sti
>  	if (ret == nfs_ok)
>  		ret = check_stateid_generation(in, &s->sc_stateid, has_session);
>  	spin_unlock(&s->sc_lock);
> +	if (ret == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(s->sc_client,
> +					&s->sc_stateid);
>  	return ret;
>  }
>  
> @@ -6546,6 +6634,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	}
>  out_unlock:
>  	spin_unlock(&cl->cl_lock);
> +	if (status == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(cl, stateid);
>  	return status;
>  }
>  
> @@ -6592,6 +6682,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		return nfserr_deleg_revoked;
>  	}
>  	if (stid->sc_type & NFS4_STID_ADMIN_REVOKED) {
> +		nfs40_drop_revoked_stid(cstate->clp, stateid);
>  		nfs4_put_stid(stid);
>  		return nfserr_admin_revoked;
>  	}
> @@ -6884,6 +6975,11 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	s = find_stateid_locked(cl, stateid);
>  	if (!s || s->sc_status & NFS4_STID_CLOSED)
>  		goto out_unlock;
> +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED) {
> +		nfsd_drop_revoked_stid(s);
> +		ret = nfs_ok;
> +		goto out;
> +	}
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
> @@ -6910,7 +7006,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		spin_unlock(&cl->cl_lock);
>  		ret = nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
>  out_unlock:
> -- 
> 2.42.1
> 

-- 
Chuck Lever

