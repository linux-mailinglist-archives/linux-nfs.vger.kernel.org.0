Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1365B8EE7
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 20:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiINScw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 14:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiINScu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 14:32:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D77330A
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 11:32:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EIUjjI020093;
        Wed, 14 Sep 2022 18:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RQzsmq4OgLo0F/SuuqkR/pVhP5Sz+LTt+deXtiADOvY=;
 b=QgQpRvjUnx1To7+709SFvKtcv4qL0JoeF1PiuJHxBTYZ6r26wFZyvWrUMIpU+2g+WGpO
 uhI6KevzlgstWhgND41iv7bNJapkF8ClSlCYN+CZtsXA7BeBzivrwPIOp4fWIS7vSboS
 YffY49ZGXNR7sxS2/NZbOUG+N834Ll3A8HzLUoDQY/BZfT2fd9+P44jLDxOFGqQRwCH5
 r62dwJDQ0qpD/R7XTHnO487FIbAxzxF4tV9RqobQU6BuD6YejsstEkSE0gUnZS10v0qF
 7DA7UirnppIlisekh2vKugidRtWt5c6b6aq4qr46GZdwDNt1OcHOUKt6sqkLMZiJL1cP uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypb83p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 18:32:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG5jQg020748;
        Wed, 14 Sep 2022 18:32:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5e9nef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 18:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQs0mrY4ixbzmGx303p3N4AIaZD9o8Cfk4VmxfYrFwLSVb3FhxrZjA4j1pIlg6B7Q5eHswxOAlRjmFb/Tus6RMY75f+KP9J67efH9rP9wGHxPbzg2fIH4bs/ojTCzOZQTbHvqQxzQQTGq3niMM4uVSJzVuJVBywuZlqK0wHVu4vih7F3gBgQhqLxZ9ie5RROWi1B5xv1WhEigoDKnH42b/DgVhseIEIcMHnSRYV/aqxn14wK2+1kWjQ06iaoBZUi1/5AI5Hc/mJmel2rzK0schyDKb8rXNIYfNC0tWeUJZiO/7czdvVQW8TmpCeQsNuxxIQRL60HI3M17bEhMmcYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQzsmq4OgLo0F/SuuqkR/pVhP5Sz+LTt+deXtiADOvY=;
 b=APE5rD2qMFB9iG1ZtI4BK8RYTSKh+xrnKnOIHKQol6LtyoA9oN1vZBCtfXqc0/B4UGExUUFA59w5uneAKN3JwFbnWyMit7qAkE1koTCLJhQMiGaA4uzF1syDCMwmtsYxt6JHqcjdVFqw/Rzfgj+7+lEvDPA+hWbbLNEEh8cTDuNPpc640J0tuVVSgnC+TCKOPQLXkl7H1/fq3G/1FLzelL1HS5U8VSrrHqj5MSMEyhgCcGZp+7DAhxMQG1GDUouopQ0nYxMp5haOjI6TDOCy2k00NbX+wpMMIGP2DjOCTkbONzo+1yXAORVgbOoryCVwWC6o6QWkg9ttcWFv6Ak+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQzsmq4OgLo0F/SuuqkR/pVhP5Sz+LTt+deXtiADOvY=;
 b=OLPvvovnzd85+Ox1B7qy5hV914saQQxypwJBoWsl2VsU6U7xJ0T7WAvjIv8AmByZKg+ZTT3uWeQZ28w2Wo2O/EvRA9dYtFL53ICwOIlLOz7+wMaoxWUxdQiofVBvPl9RJn38fAQxoMiSjrpZ2OpM1WS2w9StFt0+6F6N4pO92Kg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4662.namprd10.prod.outlook.com (2603:10b6:510:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 18:32:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 18:32:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v7 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYyFJJYLWwSGbg6UK8c1yaM0qiU63fQBQA
Date:   Wed, 14 Sep 2022 18:32:37 +0000
Message-ID: <0E0CBCE0-0270-4086-91F1-901153A9D2B0@oracle.com>
References: <1663170866-21524-1-git-send-email-dai.ngo@oracle.com>
 <1663170866-21524-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1663170866-21524-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4662:EE_
x-ms-office365-filtering-correlation-id: b7309cdf-b6b6-4e1b-e648-08da967f7f9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxT7SAvdEobv3dqZD8GE8mBZJkme80cu+KSXBHt7PZtxHxQXUj8/ALFgpr7HwdiSCyBsv2UbXMdwYmJrTI/s9WKlEqPOQf8PBsRKqvt2WkP79/vbnDsDC6ujMUsqAXJzaCnnm9moN24vhXuegTfvmaOrbKnQNuOafgTKYdPXYMH7CXpPXEX3znccqFDcgF4DyYAgYV2PZn9Hlmmk4C8QTT1dLP6KpiE6D1teM+g+La8LKEhrd4uZFj9BYld1g76mhb0dw/ilNoNWmfursYugP6PKLNZmUWH9gvJB0j4MiJaNbz6Snpyz5sGTw1WEQbLv4447HXDACAzJBjmu+iDUaCPIJlWae6mNdTt/HGPi8t5YjIzSWao8YR+N1RIEKxfVBr0PgKADiT8+YR3CpfusUdD7+9jZcLZjajjexC7nc3wWFQyidSCxGDYOTCLHfBotx7f5f7M7/ivO17TbwEJll5EswuMgEbNkaKdw2D4dqZo7/0ErnTRg1FjbF8//fdvHobeucgyVfsn4OBw/+CZwIVlnDOKKH2Wl6QbBWlz035hgVV35pdMWlGHc6rtvXkBkVJ3uik9vgDKimWQgVPB1Y7c0b6s/QagxtKznB75SgDw4lzArqmqn4rHxzIbmLWTzKK1/TDuP+h1sM6Gw1jUQ2SoEsIaO+8k6i5kwv6EbbLCcwnTm6lYuBe8DLXiqUFBwhVMapzSYjIt3a2fmlXYfLywf6cuiyO5iEcqZ7vk1uWVOW4Pc13zdB1BDxBqsTvGvpzTk5hysOk/TLkd/ezANXIiPP6qm1Vap+oYFnt7YrEE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(6512007)(53546011)(186003)(6486002)(26005)(83380400001)(91956017)(66446008)(33656002)(8936002)(6506007)(38070700005)(6862004)(41300700001)(86362001)(122000001)(478600001)(71200400001)(2906002)(8676002)(6636002)(66556008)(2616005)(66946007)(36756003)(38100700002)(5660300002)(37006003)(54906003)(316002)(76116006)(64756008)(66476007)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hc78hl6ZLXm5I7JsO/to3XeD3zGCBgnC7VPTXJHOo5OGOAQ+075x2BZgexQa?=
 =?us-ascii?Q?EP15+sj51DLQrcF21xKpqaYj/K1UGvTlfe5fZxXGFNsSiIkaV250fdvnBkwK?=
 =?us-ascii?Q?c2keDxu3TdQ2YxEH7KI0YbUWmoq3+wGoUwfNDLcij+msC7fR8aFgnpsR1X+l?=
 =?us-ascii?Q?VwFyBYkSS6z1zJGW9vNF20NI/9lVG//QHSJ1xRFkSAfURlnllGVWfrSazndB?=
 =?us-ascii?Q?jOrsbMs5601Q1k9YexxHhZ7CXt2+w1pCNrFgEdqVJddAJmydglAwKtYxpoVN?=
 =?us-ascii?Q?NC60mdci5cmbCgUNtZNwzc7CQThTyPDYFULGqi/3n29KyBxZK1awBTsLBKmW?=
 =?us-ascii?Q?s528Z+UTGd6FHHH+Fk4/Zq1KSWLYBwQJpo0yLXAXc2UM0MFoOGof3t2nT5nE?=
 =?us-ascii?Q?0oqbXphwu1ZM8VUdHfDzV9QgiLIISOKmhlCOHociCdYBesYgy2t8/l8tMW87?=
 =?us-ascii?Q?yP7zVjLwigtS0sBu+bRJE0pUUVj6p1VNGwoi837jexsnPs+tC3bEifkft2jc?=
 =?us-ascii?Q?VCg8N8V1yniRweCunP4RheA4faQUXJfrONQ4BjUwFoaJGMjiRw0QX3tU/x0f?=
 =?us-ascii?Q?jHYBDO/U0uGnjPo5+xJHpUWvoR1Ct0IvQyfnS+u1yF7me8rOg38Zv7Tjwc/1?=
 =?us-ascii?Q?VyeSZ37KzID8QPKO1g70xQsoU7RGTmWsPf9OBgGAFM60mpdOnkfU/Y86tvk+?=
 =?us-ascii?Q?XSWwycrkw9v7yKhGVAu4lAePj56U+CF2Wz/TstlUOnWFNhg/1GhUk6K3o31t?=
 =?us-ascii?Q?33QqwdviBFwlY7E01k/WxBKHh+mudXdiSI1qFka7iAtQrJx4v1m0cAoVr3jZ?=
 =?us-ascii?Q?jkCBlBM/bIJRHXtj1hwXVCUWl3skYMGBvbTr9jujYyAvRA3SimniYi5HkdaS?=
 =?us-ascii?Q?Tjf/q9gDnlw7rhqqGGuMqMUvZDuTOtIOGeBujmb5Ew2+rA93l9U+WskvceW0?=
 =?us-ascii?Q?AunJ9XWveE4W7LhGUWoahl8p+MBZFARUQqQr9tAZCgnhX+5U/1aQxYe54/9/?=
 =?us-ascii?Q?7fzdneyrbHx5acoQXHYkIa6wngCEdHTOMJL2aARbL6U+JY05jfCoOw+T4Jb6?=
 =?us-ascii?Q?SmB7sOlblFyWRAuVgL/pm7vj5oPRG9iDZU7YiXgywTu+0io10gQ8/io3E0uo?=
 =?us-ascii?Q?Fq4/OvC+l2PWNaAmEce6nc5qBgxoC1e3d/rZlJ8EQ0/l7BRmvovUx87jUkdD?=
 =?us-ascii?Q?eDwr2WKWxN6FbKrDaOcAklFbd7ZjgOUt5c3dqVXnqAWgrDrAVxIRtjCyDVoL?=
 =?us-ascii?Q?x4Fc2QstTVhYe4xgbTHn1J11JIrEupIQm/2ax9BNmN/aO7KRZvw097/1yITK?=
 =?us-ascii?Q?D1Pb9wW1ND1Af6BnP78TS8cda/4rRpLLyhny4JTTQgZukewLgptHtk+wF3Iz?=
 =?us-ascii?Q?Vkadupn49jR+fXG4QzhPwol50VLe3O1zC6BFOJxqeMSiYaKAhhBBKaOFdRf8?=
 =?us-ascii?Q?ncm3RRwYOo7xG82SG43AU/23MMqJIuc84kV0FjI8nWvhjZQNROmJfv4F0B1k?=
 =?us-ascii?Q?1vc3hWmEUdtbnAPYW7fS8JgvR3nli7sXlIz0UjCjm9XHQ3aOsmhwNIx0WK23?=
 =?us-ascii?Q?HP7y/+hVbNyu7gMNK1d00mgSNASyFkJykT1VH5PAZUMD6MGu5en8sO1Dnrmv?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CEFEB12603B6F4BB6D143DD81792D63@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7309cdf-b6b6-4e1b-e648-08da967f7f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 18:32:37.2076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZokoRxedqjulxfSJ45kONIUbmFOP+MbefyARbEwGl5w1JVantm88xUbi62TCuLjrVl4PmGd8FCMiZ1na6o8aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140089
X-Proofpoint-ORIG-GUID: hF1f82oAeO2oFQVHsZfg1rKfDkXogdDy
X-Proofpoint-GUID: hF1f82oAeO2oFQVHsZfg1rKfDkXogdDy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 14, 2022, at 8:54 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add courtesy_client_reaper to react to low memory condition triggered
> by the system memory shrinker.
>=20
> The delayed_work for the courtesy_client_reaper is scheduled on
> the shrinker's count callback using the laundry_wq.
>=20
> The shrinker's scan callback is not used for expiring the courtesy
> clients due to potential deadlocks.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |  2 ++
> fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++=
-----
> fs/nfsd/nfsctl.c    |  6 ++--
> fs/nfsd/nfsd.h      |  7 ++--
> 4 files changed, 97 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 55c7006d6109..8c854ba3285b 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -194,6 +194,8 @@ struct nfsd_net {
> 	int			nfs4_max_clients;
>=20
> 	atomic_t		nfsd_courtesy_clients;
> +	struct shrinker		nfsd_client_shrinker;
> +	struct delayed_work	nfsd_shrinker_work;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2827329704ea..62b848bb55df 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4347,7 +4347,27 @@ nfsd4_init_slabs(void)
> 	return -ENOMEM;
> }
>=20
> -void nfsd4_init_leases_net(struct nfsd_net *nn)
> +static unsigned long
> +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
> +{
> +	int cnt;
> +	struct nfsd_net *nn =3D container_of(shrink,
> +			struct nfsd_net, nfsd_client_shrinker);
> +
> +	cnt =3D atomic_read(&nn->nfsd_courtesy_clients);
> +	if (cnt > 0)
> +		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> +	return (unsigned long)cnt;
> +}
> +
> +static unsigned long
> +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control=
 *sc)
> +{
> +	return SHRINK_STOP;
> +}
> +
> +int
> +nfsd4_init_leases_net(struct nfsd_net *nn)
> {
> 	struct sysinfo si;
> 	u64 max_clients;
> @@ -4368,6 +4388,16 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>=20
> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
> +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +}
> +
> +void
> +nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> +{
> +	unregister_shrinker(&nn->nfsd_client_shrinker);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -5909,10 +5939,49 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, str=
uct list_head *reaplist,
> 	spin_unlock(&nn->client_lock);
> }
>=20
> +static void
> +nfs4_get_courtesy_client_reaplist(struct nfsd_net *nn,
> +				struct list_head *reaplist)
> +{
> +	unsigned int maxreap =3D 0, reapcnt =3D 0;
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +
> +	maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
> +	INIT_LIST_HEAD(reaplist);
> +
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (clp->cl_state =3D=3D NFSD4_ACTIVE)
> +			break;
> +		if (reapcnt >=3D maxreap)
> +			break;
> +		if (!mark_client_expired_locked(clp)) {
> +			list_add(&clp->cl_lru, reaplist);
> +			reapcnt++;
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
> +static void
> +nfs4_process_client_reaplist(struct list_head *reaplist)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +
> +	list_for_each_safe(pos, next, reaplist) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		trace_nfsd_clid_purged(&clp->cl_clientid);
> +		list_del_init(&clp->cl_lru);
> +		expire_client(clp);
> +	}
> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> -	struct nfs4_client *clp;
> 	struct nfs4_openowner *oo;
> 	struct nfs4_delegation *dp;
> 	struct nfs4_ol_stateid *stp;
> @@ -5941,12 +6010,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	}
> 	spin_unlock(&nn->s2s_cp_lock);
> 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
> -	list_for_each_safe(pos, next, &reaplist) {
> -		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		trace_nfsd_clid_purged(&clp->cl_clientid);
> -		list_del_init(&clp->cl_lru);
> -		expire_client(clp);
> -	}
> +	nfs4_process_client_reaplist(&reaplist);
> +
> 	spin_lock(&state_lock);
> 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> 		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> @@ -6029,6 +6094,18 @@ laundromat_main(struct work_struct *laundry)
> 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
> }
>=20
> +static void
> +courtesy_client_reaper(struct work_struct *reaper)
> +{
> +	struct list_head reaplist;
> +	struct delayed_work *dwork =3D to_delayed_work(reaper);
> +	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> +					nfsd_shrinker_work);
> +
> +	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
> +	nfs4_process_client_reaplist(&reaplist);
> +}
> +
> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *=
stp)
> {
> 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
> @@ -7845,6 +7922,7 @@ static int nfs4_state_create_net(struct net *net)
> 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>=20
> 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> +	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
> 	get_net(net);
>=20
> 	return 0;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 917fa1892fd2..597a26ad4183 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> 		goto out_idmap_error;
> 	nn->nfsd_versions =3D NULL;
> 	nn->nfsd4_minorversions =3D NULL;
> +	retval =3D nfsd4_init_leases_net(nn);
> +	if (retval)
> +		goto out_drc_error;
> 	retval =3D nfsd_reply_cache_init(nn);
> 	if (retval)
> 		goto out_drc_error;
> -	nfsd4_init_leases_net(nn);
> -
> 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> 	seqlock_init(&nn->writeverf_lock);
>=20
> @@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *ne=
t)
> 	nfsd_idmap_shutdown(net);
> 	nfsd_export_shutdown(net);
> 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> +	nfsd4_leases_net_shutdown(nn);
> }
>=20
> static struct pernet_operations nfsd_net_ops =3D {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 57a468ed85c3..cd92f615faa3 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -343,6 +343,7 @@ void		nfsd_lockd_shutdown(void);
> #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
> #define	NFS4_CLIENTS_PER_GB		1024
> +#define	NFSD_CLIENT_SHRINKER_MINTIMEOUT	1   /* seconds */

You don't need this definition any more. I can remove it
when I apply the patch.

Otherwise, these patches look great. I will give a few
more days for more review comments.


> /*
>  * The following attributes are currently not supported by the NFSv4 serv=
er:
> @@ -498,7 +499,8 @@ extern void unregister_cld_notifier(void);
> extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> #endif
>=20
> -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> +extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
>=20
> #else /* CONFIG_NFSD_V4 */
> static inline int nfsd4_is_junction(struct dentry *dentry)
> @@ -506,7 +508,8 @@ static inline int nfsd4_is_junction(struct dentry *de=
ntry)
> 	return 0;
> }
>=20
> -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
> +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0;=
 };
> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
>=20
> #define register_cld_notifier() 0
> #define unregister_cld_notifier() do { } while(0)
> --=20
> 2.9.5
>=20

--
Chuck Lever



