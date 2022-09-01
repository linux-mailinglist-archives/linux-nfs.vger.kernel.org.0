Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3987B5A9D00
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiIAQYw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiIAQYu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 12:24:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F5E81;
        Thu,  1 Sep 2022 09:24:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281GNvbc023888;
        Thu, 1 Sep 2022 16:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eQTvKTvF0i5cw2oqSEG8YDbEZT5pery8iyVw0QvgOLE=;
 b=Ms4IESFHAc2BuWO/pFvl4O+cMeqinGWiJ3k6Re5nvHpWqvp/nlD4q03x9eLG+q+YzGoO
 LI8gWsCmVVgI/spYgxdjZ15j5cBjaQLdzuCbQmQx8s1HXWIDHawr34KjHf7lu2XKTJVl
 qbAjCCCOoyAGJ5r2202ylxbOUsbemwr2YPt0Md1Oav53d1dKJZlkWd9Czm9vMhedXF2d
 lkUYEpXeyww3bIkbrGPRdwPNKmC7pSOA3yzH3LN4ZSYo/FiXaZKxtnv1ctav9swimyS3
 hlcIXF9OfxokMcfEACf8wDx8rK7eBO80XdoyPXjQmnyIL/0nTYo6NTgqhipKfxMSApCD mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a4jvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:24:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281GCFIq019696;
        Thu, 1 Sep 2022 16:24:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6n2r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMN82fX/RMFe5CO4anLyC0exkNicRpO7mGKO+xqOmwsIvCsHJe8sa0U59v5THdS0xBNp7MmyUKUMBQBAXdAZQlrfsZjevBhqu+VPJ3Pa0VzSBc+zknfc5tFabJ0XJvL0rMCTsSCwnB59+qi95QiCDPamAzKuiIqZoED2iZKQngnryTJsdWMOQa/p7L1vIr92KHLdOErabHxBVcveMpdET+GATK2q0mK2dZpNHAZQNVOa3LFaNzHfJ5IWIxRCjzK4SxjhVFOcadDUXx6nyRQRhuj8bbrmJIevk7juYyCHz9rO8UvXqaSU+04pYlwHmq9VipdyZxhQAGBjC8CEI1kXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQTvKTvF0i5cw2oqSEG8YDbEZT5pery8iyVw0QvgOLE=;
 b=VHlIBwFDKmVwqj0KjFCNOsOPAbHaZ5IvQDi/b7OvCwW0HExrnaWK4nPBn+sHTG6JfXObCMNvS4kLZioxeVxlVPv9bgttKNKkrOWgRF7zfFoM1wju6KWWu/rVcY7ogXw3DdgK5TycTNMJnJG7Q3nZXRvkMordxnDKzAD7p/4lj8uAeG3BysxQt//jX0VIagTs/BfAQSGpwvOmymwTo24SFHNGlDDD0jtSmvnfChpnU67jjfXM2YAlRQOeGsr4CZuWRsB7WVRC0M0OMHK5sZM24hTigrgtI7tgILTmL5AVRF1QwRwXvLko9lkYylotqMiYLewjxxb0BBKDNf3dL0J1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQTvKTvF0i5cw2oqSEG8YDbEZT5pery8iyVw0QvgOLE=;
 b=WZ13trKRjfapcF+JlObhkL11QoyZ44O2Z9nYOxZNGyUWyk90HJc9tnYbJflbtyzhFVJ/x9ZBHXOnE3S2K8AHhvCAcYE7tN9A5ifquodpWTUex0quCE8WLF5y/bsxRWTkaDcoJq5i/xUPGN171DtuKnxM8k9lN/+iuupfdYE3Zj0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5237.namprd10.prod.outlook.com (2603:10b6:408:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 16:24:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 16:24:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jeff Layton <jlayton@kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] nfsd: Fix a memory leak in an error handling path
Thread-Topic: [PATCH v2 1/3] nfsd: Fix a memory leak in an error handling path
Thread-Index: AQHYvcN+p7gwXmsrPEWOSmDIsKimnq3KbmsAgABUtwA=
Date:   Thu, 1 Sep 2022 16:24:39 +0000
Message-ID: <45CAC18F-1FEE-422F-B9B8-4B49261713B5@oracle.com>
References: <14d802144c88da0eb9e201b3acbf4bde376b2473.1662009844.git.christophe.jaillet@wanadoo.fr>
 <5c5d87f8329e44275bda36657be4de2390f065d4.camel@kernel.org>
In-Reply-To: <5c5d87f8329e44275bda36657be4de2390f065d4.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd0f3108-f07a-4a5c-1f84-08da8c367801
x-ms-traffictypediagnostic: BN0PR10MB5237:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4A8OAK/HB+THZAjS4764QPa/5XpJDYOQhaymF/ggeBytZvIFA8V9Fk0zfuBXXUWHL1w0Ff4VmfS5gc1VK0tJXbP5X9tHRgaoq3A9Lvh/ZX3r0xQwe8wXQQwo9Nn9VnSvokr/3sD84MXRE6D/J93jLTtn1JL4yb4cPp8KknG6U3hLEEbHpzFKYAsos2oIX6pQ5j5uCwwS14OcCi5wx78oVBnGYYu2aL+95lDyjGxVO0sITLgFQw3nmfWsHrLNuFmefnxguSPymGDAhO1EKBAsr7yfzqKmgo8U06aHFxgVeMcjtGD8HowIon175F+yrk+tPMkjEgiagUQ7DtOVO4PSneTP2pt9f53S7dnIQOSMs8hEa0xjGtbjIXz7BCtYwD0sWhnKEKsDAcTYAOLRqaoMqUK3DNvIJTo3XVDuRbygff+6SHoPrpi0Eoq9e88eFve4KCQQj4TYJ41boKGhINrFIvD5P4e5neMclPwiqcOXf4gjShYFlvn7gmBJnDDve+OuJGG5u+fic1t5f2vu99ZcADltEK14WsCQfwXLMvkoUh/qSSWGm3f0ZKP+UQGDK9m8IWmdhz/0+PDD2/8iQGQODiIoVpOVQ7Fz+t7VYp8pmF25rlYe5P0rUCUBV1zVf11TgPXP1pHEgmSC2ImPKNKGQpQuG2g7IlNP+r7IPuwQ5T0Itd/erWvx8csMojrA0xqzLCvrCFOo0typqzM0dJLvjPmsgKaqCtR3I9elmq8hteMcNqO7Y9HGugphfy91Xo3JdYMrTavSMPWK9zxJ0kpCDrVT4Z32KGtg5/QF13SIXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(478600001)(38070700005)(6486002)(71200400001)(54906003)(66476007)(91956017)(6916009)(8676002)(76116006)(86362001)(66556008)(4326008)(64756008)(316002)(66946007)(66446008)(186003)(2616005)(83380400001)(8936002)(41300700001)(38100700002)(53546011)(6512007)(6506007)(26005)(122000001)(2906002)(33656002)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0tl9Z3pf7/D5bIRLJgqXSJJAkGR7yJYYMeS37ZjBUt2MHki1C0NwHqmZ8Bc?=
 =?us-ascii?Q?EohiKxYddbQwUYLn6KKSaGa38nUzqK55UuRCsGBcdwTQBG8q1HlePsTIT9WB?=
 =?us-ascii?Q?tICawXNvdfJ2o486VzjDdMIK4Azm53D0X9IGrdoIfV9uP6juOI18p5uahPQ+?=
 =?us-ascii?Q?akGd1xYmq567Lj682k/gteStyMUoNb4VjnzAHJXG1xh6OUCSK6xsPaipqJDa?=
 =?us-ascii?Q?QhsTSrngvWFQGlkvu6q5ZyT4GZ9rQlBfydjdgU9n6hiaayaWT8dzQVhMgkO+?=
 =?us-ascii?Q?59hcg/NBBhqZb8/ZG6cTkcKhvPTz1xtIlYuCFDL4Ej9jxkbl5qPWj8qnKHcH?=
 =?us-ascii?Q?fzqvAyTuY7yTGme6Ft+V8xN+KTL2ErlkM5xYwYbvb3J63o0oMXFT+ZtcGzf2?=
 =?us-ascii?Q?SQSyjqGn0vfTXFMW5sXKDR0XSqyjXcSzjMjQ4uP4iZ9nPMvi1HC0fppyUsCF?=
 =?us-ascii?Q?87z+q45FhWvbucUvjR0wuyB1UsSfAnfJfiy2ala7KSN4+pNcVobYVOWHHA1b?=
 =?us-ascii?Q?ULmXC2ZvuerE3QxJ3B9GcShwKM6z33mtu9gOY8vCun2Zv00Tln+enh3HitE7?=
 =?us-ascii?Q?Mgc9wDJxMq8MBpygxbSdEhKo8PNeA1WtbmOl5fta3SbJZUYW4ed4w3ymNM07?=
 =?us-ascii?Q?JEoUI2jrwiLmtGFyk9xoH7NnPGjfqsVLltY6W+rEqOKLB3DnAdZ1mz9agoEm?=
 =?us-ascii?Q?D24hhHY4X8KAmr0vImN3KWAoVBokzNXXTp+2yUaSwfHdMdvu9K67JcbPVP6H?=
 =?us-ascii?Q?+Ie1k8XjiIPWL9FnAHe4ekOis2zqXOG9AoBNkxIVCcwwJiX5QwcyVcpEG9tN?=
 =?us-ascii?Q?aJaLN7XlAzmPFBDdMz4HON67uczl2uk9orzgPalISuEDLvakogE6HdGL91n0?=
 =?us-ascii?Q?eqbNqKcxh2om+WneSPQHk5CoS9cZinHkB4Oi+XO3MYr09gR9cbOsqyn05ZSB?=
 =?us-ascii?Q?H/QrC3HAtOR2959ASnJp4quZtKSQRZkMuUkOecd1CEHn3hgJ1t9ORBIujVY3?=
 =?us-ascii?Q?4IIbJg6CB/Je69VW4n8kfDffRp+ERK68uGORjL+6raBR3pdOF2y0ngelpKWu?=
 =?us-ascii?Q?z9/P/2viyPPVxLNuLLnWkfODqy+kqWZhpu/wjvepF0Osc+xTwhruBfJ0lbJ2?=
 =?us-ascii?Q?AjYh9IrFmCSCOSWh388Hmq7IHFI4FNhYid/aBWE1f+J0iGTYEnFHBJnj4+He?=
 =?us-ascii?Q?knD2tMyvBTjgHLd951b7G+f4a7XXnCDj/fCCVw2t9UD6YS1WM+Oq5x4+YGNX?=
 =?us-ascii?Q?QoPWMTXF7sV+wl/SSR3RpJj0tok8S8geMv3L0CG37Gawu+q+k7nfRX1V5Hb7?=
 =?us-ascii?Q?9w0YOaeZbh8zHfndchwz/xQa2txH3s+od8JMNkPMvhBQounZkciXGIjgKIqk?=
 =?us-ascii?Q?fwf7cN9PytNQuOypgHuYAfWukPIiNMzYaCwpjaoROl+5StULu6yvWhdPZOs+?=
 =?us-ascii?Q?0OT46gxMv5GB315ugUpwGgg1GGgQjtf4jh3UIu/sz5I3QSZW1rJ3pqv3IJ3K?=
 =?us-ascii?Q?wKGSm9WlmRWxlU9CUDlDFlE+6hJ6tZsEJaUF9xeFRb7eQcZyoE+k8lV/wAPF?=
 =?us-ascii?Q?AF6SqVKDiIL0VlI/pasgGxwiYak356H6STlVS+F9rEAy8wyrC6WS6CBgSyyO?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <894CB29937481D45AB472D940A6D3747@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0f3108-f07a-4a5c-1f84-08da8c367801
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 16:24:39.5183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yrse7iiohLV5rDsEpXPF19MP3n9siuQvAMbyA9tnOGoMqZkvmx0cs1fjI9srNJhMpVQDhIvhR98+wcYLvVGRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010073
X-Proofpoint-ORIG-GUID: yoASm8yI0io-SPf4ZvxN6u_I5GydXgLw
X-Proofpoint-GUID: yoASm8yI0io-SPf4ZvxN6u_I5GydXgLw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2022, at 7:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2022-09-01 at 07:27 +0200, Christophe JAILLET wrote:
>> If this memdup_user() call fails, the memory allocated in a previous cal=
l
>> a few lines above should be freed. Otherwise it leaks.
>>=20
>> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> fs/nfsd/nfs4recover.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
>> index b29d27eaa8a6..248ff9f4141c 100644
>> --- a/fs/nfsd/nfs4recover.c
>> +++ b/fs/nfsd/nfs4recover.c
>> @@ -815,8 +815,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg=
_v2 __user *cmsg,
>> 				princhash.data =3D memdup_user(
>> 						&ci->cc_princhash.cp_data,
>> 						princhashlen);
>> -				if (IS_ERR_OR_NULL(princhash.data))
>> +				if (IS_ERR_OR_NULL(princhash.data)) {
>> +					kfree(name.data);
>> 					return -EFAULT;
>> +				}
>> 				princhash.len =3D princhashlen;
>> 			} else
>> 				princhash.len =3D 0;
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

All three applied for v6.1. Thanks!


--
Chuck Lever



