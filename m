Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583EA57B890
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiGTOcB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jul 2022 10:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGTOcA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 10:32:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F53A3AE77
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 07:31:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KEEPm2016431;
        Wed, 20 Jul 2022 14:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JAsEFj1QVxCGdUajw43WlwDQ+z9fyo9PszU5eoGpvk4=;
 b=rW3m33e4ht0t7ikJr1gzahqzRv7RYnHgmuETOUhFktgb35HSuAvGjWf+by4wnMPfdV4D
 6PM3XdGx9F1fpt3HO2bFjl36rb4iGsxxVArTGfO9Uw02Ik6nu7ais47jbdhV04yZvXeg
 62W2G7DhlT5AdISER2ulTXuEkkSEf1SWZtTjVkQ1A/uI65wmgJ1CBRBn7iT85DWojvgY
 /gZ457iKSPb/lew1RXsoCqAZvaTJSxVc32ZroPMITBMcm3++6KnQWluHV/gBWaDKg+F/
 vVvnoXhcas0YR33tCEvtd4pb+HvRbPKERDeaaumV38xoPCZu/+JgTVyd4W81ONt3ivF4 Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvthqt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 14:31:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26KCJQZv009934;
        Wed, 20 Jul 2022 14:31:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gheufq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 14:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6uwRPrq9OmbyKxf3f29DrcKStnyPTI0z4tIfmS/NV99b54DT6v6+Lo4iFnuiox1MYwnFNp7jkUjp9xyfSXtV2BQBRBppBUSJx4rR1/oX8TaoABjfxtUpWFo58II/gnSbCiGctzOrs+NLtRRUf2ESePcKONXvFq/MO9tNqtJ+TyjXXKfHTf7XX4da/Bo53giKQdAQ+u7lxKHPsSf0alqdodrb+DYSujuZHpY0t6SjLbbrUzBQMGRZxr9zm5DL2NZZWMuAkRdXRJXaRtSCs1fP6ZNbboD46Hp6ik5TDPUSn4CgcxMbVgGekCDRZsq4SAP45tFdsoihgSoK32eQyIT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAsEFj1QVxCGdUajw43WlwDQ+z9fyo9PszU5eoGpvk4=;
 b=b2Yqmfdt4T77gaJjENmDiDTZcO6blzjOnPEWdxG88LUskf4Bb0lkszIaQit4in19UrkCScZrDT54XRcgVRzsfiimocPZugfwZ76YwtNk1du4LRYtpipPPzLyFA2jljn4CuYdkpY8z8QMcMvorZS8Qgi0a0vkQK2/zocTT8SVIh8ObCMMEis9DmnVB5GXYfLV3nthRKKQKgnwWJbvgljKzgXS77Gq8BQ6BHbNKWDskccr0BQZYFfyXiU8SAbUaBmh9hoF5qgOzgPzoCbZpq6a8iyUcK0LLicAi/KE8roYAuPPIuAFPJ4aK4LG6IzKyo1oZqVANVVNTOs8CaRfHmv8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAsEFj1QVxCGdUajw43WlwDQ+z9fyo9PszU5eoGpvk4=;
 b=Nixxay07d6XiVgm6lAeau66VlZp1B/1lod+0TVpFBFPz9g+t56v0UrYql82+0UuYR6SykzChXApWb449Z7D/clp3H5/ow5PMGBSFVitB/Psc+F8uOJ57FL/H1Xp7JakZZ77athaZwMw4P3lyjl3GiTvn6XO6DEPFiZNNJ6hgR7A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3929.namprd10.prod.outlook.com (2603:10b6:5:1fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 14:31:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 14:31:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olaf Kirch <okir@suse.com>
Subject: Re: [PATCH] nfsd: silence extraneous printk on nfsd.ko insertion
Thread-Topic: [PATCH] nfsd: silence extraneous printk on nfsd.ko insertion
Thread-Index: AQHYnDXDCa1WjW2RSE2Z9XOjlUB/EK2HUm4A
Date:   Wed, 20 Jul 2022 14:31:41 +0000
Message-ID: <97227EA3-8930-4478-8D2B-6BE9C36F9779@oracle.com>
References: <20220720123923.16753-1-jlayton@kernel.org>
In-Reply-To: <20220720123923.16753-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4648851-e8ce-46ff-b158-08da6a5c9008
x-ms-traffictypediagnostic: DM6PR10MB3929:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sq8bMnqf5ZiJRomzxMg5ZGHjiplVNoYXeKTE9KvZDPwiTi3uQj1dqphQBwdsfZJ2M2YausniLK5eopXvn8awax8fZRkk9NMR5ruFQsTqwcD47Y4ULSyt76TDWHEFHSMq5Uh3pbCXRvBuZykeu5ZMTWws2NK8Ip7Z3+Tlq4jhFADIMTIjVl1qbeBDg6tceCfRf0Vt+jeWkdmYIu1Kw/LRA0STW5wbSVw4w8fYEWdLRTt1FkZrpU825hEc6c++KyYjFBc0lI01y2UGePb9TOaTviZ+93cYSQVbNjAPIYmx7X6jSIKI2xzYIxxPSudApUEg6D1+9C0dPTQ82/lwHS5RPEqudNJ4y3QxlNXNLvRFejhwnZoZ7L1HSO7AZ189XZ12jZBesJkuCxG27ty53r8RkZivppUhsDLMHewZJActGyJXzHg/UPpwQvpmEgg3rJ31l+pVAw0Z3UU88WrPoKNgBkNmT4rxIxKVILtMSOG8lBH6D+QWxhvm+QOsmH8hvLIRP6NhoI1z8UjcO7cX9IAgfuMl1hnYQN+/2NBo2OXQKr5glyN5HdfgEkx/TfOVi22jZAqnsA3l1y3jv+6rgcjaUs+rWplCbOwkEUWvkXDv8T0h8GdY7QCGrEnAlLuJ5B9cBqffBhq02LDHpO+FRzrZEVYLkQVQLEf/PEzeeOzELVUzIYP3cwUQcxC/OmQZkkNhSOK2AG3ZaHrWR7HqQoqXbo5xZHfoJK0ggMkN3WMpYLoIbaF9WWnkQaT8vO5H/uxvurgv/SDEg/oQlpAP0s1qT47Dzvzs7RlijZK+UzfWwxL8I4AKpaLeEe5G3QYkZho4dPVB98TpSVb2GOjRKK5Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(376002)(136003)(39860400002)(122000001)(41300700001)(2906002)(53546011)(6506007)(186003)(38100700002)(5660300002)(6512007)(33656002)(83380400001)(2616005)(71200400001)(66556008)(91956017)(76116006)(316002)(6916009)(54906003)(26005)(66446008)(478600001)(8936002)(4326008)(66946007)(8676002)(36756003)(38070700005)(66476007)(4744005)(6486002)(86362001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xp5rxTtoA5s+DwGJMUITfEJ/zmUke7AK9gJ5cqHg8ypguTMvApjcvRYZJuqE?=
 =?us-ascii?Q?9Gne/dr6nFzJgtzHutXC1lTZRUHSKPyE6QmBJv6oW1dxvImWjhnjhdgr6fX0?=
 =?us-ascii?Q?Tp0I8sqiebVh79uoZOIzouB1oYYGs8N2SmsZxOc4mzdEb1moO2aOOu7ffi+x?=
 =?us-ascii?Q?uCedDVqeGrBU1RxvR3V7BYH6VkGtMpFMjW7GwjYLfFuJGwuO0Is6rXQ6xA/1?=
 =?us-ascii?Q?AETrAuDPAmp7NZsPuz/vLHZ81ZQdP3TIA7MZclF424T4rYi7H09mUUdwg05t?=
 =?us-ascii?Q?1QXHxeWfh8jeKThwxBLvgiDsxrXFQDF5AnewwvR28jmO6Gk34tFtIQ8W0GEO?=
 =?us-ascii?Q?SteAWmIpGI7bi/BnhO3EIqe+NXtoqQqxouJfVxyaxn3BE1Fgo5OKUZewTIPE?=
 =?us-ascii?Q?hAB1w8XPHpvS+Bh9+2oMWBL49q1KvN2QGGLyZIRu2lCi7Llp2/ADMOsNq1ha?=
 =?us-ascii?Q?fFCZQ88EU/StrXzfiIGDN8ySYwfjKhb53bGEaqr6TEC1JeCGKIgzzaDGJozD?=
 =?us-ascii?Q?muJgALP+QDFZ5Dmm8zojN63X8XOIxNM/3tzv/mq6Tg4Yvur3sn2YSsuKvRt8?=
 =?us-ascii?Q?UksrdNJuWVb8YzDn1YzBkdAAEpmmrrlfyfl03cLCzZv1R+qafLl4vD/Xn4Me?=
 =?us-ascii?Q?sYuETVY20GxVn6EY7TQ8lb57PuJq/y/0CMFnf9eiTo+OQD5YKMvPeaxC+m3v?=
 =?us-ascii?Q?NJ7F9qYW3LWo2RWgtIZkmOxioOvXO77YSwV+VOXynY5q23RNINJly0P+wMR6?=
 =?us-ascii?Q?fqyrUyX1K2AAwHMD1LmpkO5tXucrF1ud6oFiUcYFpGhcoFYcK6ZffH7PLR5m?=
 =?us-ascii?Q?wE25AWHYfB4RkIViDjPkSy2ynwGMr5TkkbmSlzfTMOOtqUNsjzL7kpxie784?=
 =?us-ascii?Q?WkDp38Rx6Xn68FhFmPPcQGzSM/TJ/cYSYJbNkzHKWe5MrLleWCzE5HTKdRvo?=
 =?us-ascii?Q?kshW0MyHbKNg6R61V3txAEoNoOrArpLcCxCqkXtL/ciSumQ2I4blmAVndn+h?=
 =?us-ascii?Q?UWiLCUpESMebuEXI3wqkA1HdjYfNgPE0fIH/Vt+V1aU9fET/on2dgg4alqD+?=
 =?us-ascii?Q?8dWsWrh5rzNKcP78wf33SICs3xwCEVK3oMNU8xcUw4orA3FrAk1+QkjqUKtJ?=
 =?us-ascii?Q?foO2WLn669wihfzEdQpaaJETdZqioL4gwQXmmdU/ITxhjFcau7CkH5TdSr1W?=
 =?us-ascii?Q?h2R2ylyueoAp9bGtPsYHc8pNaTsQ+3dnH7d1Z7/vnWYl15BctgBKr1sHBqsO?=
 =?us-ascii?Q?+xYXPDOg3eFQA9zzPvZ5wZDGAhloIkDT9nkdL0qC/zhsiZyMrKqxMUzG0gyO?=
 =?us-ascii?Q?JPGlCYtsp3PHiR1lYJWEnoTPV29vtXdCUSTeVC7Pw22InUj3th3oIEeTvWwi?=
 =?us-ascii?Q?N5G3CK2oFOaGxymsouBWY3citAeIudaLfUASoMkCUMjnUJxinTt/yoVhS0Dd?=
 =?us-ascii?Q?b0vVk5RdlE3wh2s/KXtc8HWTTKFTxlpoTqk8PDH89sQHng+zDGgO2flyIl7T?=
 =?us-ascii?Q?jJkDk/3Xr80SlKUJq1uM+P1MOnXcfHq3+YQNxuU5qk9pwmlFU+pBvuh9bOJ/?=
 =?us-ascii?Q?pKCgWesolkJunG53M5vLvBQKMClIUIAxmLwzYYJn2XZyMsyOJyNRXeOPwDpH?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A09E83A80079844A6D7FDC1DE0774DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4648851-e8ce-46ff-b158-08da6a5c9008
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 14:31:41.1746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzENJPEqdC3WyXkWzfcXYd8UKsJ4jgRuiEbYUDedkg/6gB660STHH6f1KZrlXT9rZWT/Rduw/qAjwp8FODSjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_08,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200059
X-Proofpoint-GUID: MKw-0l48CJzeFM9cp8tg0NV1_rZursWz
X-Proofpoint-ORIG-GUID: MKw-0l48CJzeFM9cp8tg0NV1_rZursWz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 20, 2022, at 8:39 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> This printk pops every time nfsd.ko gets plugged in. Most kmods don't do
> that and this one is not very informative. Olaf's email address seems to
> be defunct at this point anyway. Just drop it.
>=20
> Cc: Olaf Kirch <okir@suse.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied for for-next, thanks!


> ---
> fs/nfsd/nfsctl.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 0621c2faf242..b6efc3b56fe9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1517,7 +1517,6 @@ static struct pernet_operations nfsd_net_ops =3D {
> static int __init init_nfsd(void)
> {
> 	int retval;
> -	printk(KERN_INFO "Installing knfsd (copyright (C) 1996 okir@monad.swb.d=
e).\n");
>=20
> 	retval =3D nfsd4_init_slabs();
> 	if (retval)
> --=20
> 2.36.1
>=20

--
Chuck Lever



