Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04F45AA700
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 06:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiIBEcM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 00:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBEcL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 00:32:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E5A5713
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 21:32:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2821tqMo012971;
        Fri, 2 Sep 2022 04:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Xdf9cwI5OPvB4TKTi5tDYhNmL+xqFMjy+pkg8yfkSaw=;
 b=JjmDEaCT+M/KW9N6ol/XeO/E2jgDQzDzL3hd77ONzPA92cpmfPZahd8uvAmUmU9Wdk46
 zuZA38AsUAYFvWLTyFL/lfLdcKWw8peyqu4ty3xNfI9WFbf3R0mencyjvEauQ/DaVIza
 qEum3a3FwED0a6W0NbdeLBtT2ECcvoKgJ0Akm6mM/3V+jN1G+oScRzWl71njg3J4mudO
 9bO8iRjvUy0KHEKBoER9HbN+QIjcre6ih3isKGD5Oa7I/E7lQ07t8/PUiFijsAo483Fi
 cTiMCl25LpSYVIkXKClsrEm3bVr6TZTQt6//yd6TDiHFPlf9XGH21l5v1Dftg4XsSMco gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btte513-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 04:32:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28216dSh001874;
        Fri, 2 Sep 2022 04:32:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarqkhk15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 04:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aeo7luBIl5DD99XXDXfN3kvfH8OesM04Ci5XjMEXigx4ETCsyJGPvogO/Fo5KVSAtJQxBhDEH7+h2JuN1TAto4RMh1sNyk6gtDCpnM44wlrKMMojWb5v6ieNMelrT4xqc8XVqgRl/bXqWOKHLVTw5q/igYi31/1Lylae3+uDm8ECWXDBcsS87Q9ksSPuAK70g9pSNcrYk52ZEDTiMYitVBxYFfs6PEAjZQd4fvSaX0chhojje6/IEAwmtceEgJ+1KYf23j9cZzW7mz0UM2qJL4CeiUUzVypidDIDWLPZCISBKIQxbfou8aoc6N5Ua3AfDms4Llt7HdGh1mn9tbEd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdf9cwI5OPvB4TKTi5tDYhNmL+xqFMjy+pkg8yfkSaw=;
 b=hqFJXKZXWN4Hs9apU6zm0hNelhYYfC19ea+5dw3JMj+OclVRnB/cWLp9vEd1RzIN6azSdNzsiCzCfvZNAsvzoOSoVj84/p4FhCXs4jFEDJWvP9ki4R6oqQ98i1p/E+9BzaSkqEXmH04xs7F2RPWsg8AgXXcwUmKaG99M3xsmrXngxMXZvn97/615Tzi3Fm1JJS7/TidjVSNSvvcTA9LWd6TGOFdA6Vs4+iuJ0yu6XyDwKyBtkH8/84JA9EYmOc7ew9YrLZJ5S4IMWBAmX6zofodGdlG413trRllUvqX5ft4l+tuJgkb7/FSKu13J2g+bZv/LTlOwlcSv/SBSBWD4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdf9cwI5OPvB4TKTi5tDYhNmL+xqFMjy+pkg8yfkSaw=;
 b=xopbGK3lW71ePhpZ8wOA/8HsGNKjHY2euQVkok1MLw/VI1IzIeaM2KEoYTjdrFpqWhFlLGPqJ6kGNKqdsXxugFjo5Y46YlRMMKQY5v0S0L29JD+x1BsJOLzW/VB+Fq3ZyTcu93G4mrvxQ9ESFSq4RaLUyUKZ2yOrmvQuQG7nPVs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 04:32:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 04:32:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYvLpF3IXRGSf70UK3afu6RNBIZ63JEv+AgAJR5wCAACuHAA==
Date:   Fri, 2 Sep 2022 04:32:01 +0000
Message-ID: <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
In-Reply-To: <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a2aa895-b51c-4202-42e7-08da8c9c14ad
x-ms-traffictypediagnostic: CO1PR10MB4593:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtRurZ3NHoobJe1qu+lsl8KrdgTASfCzblsS2dwrTaDi4AiT8waYUNwDnvP2Q8DLfNEo8LdRth6sTVQcdZPnCMjJ44QsASsRTRvvAsp8fdnktoxB7Ln1dtTQubpg5i1+cF1bzdSOf0kGIZCpbbZ68lZfoN7Tui/nWKEgiUP3/Wb9l6TB6MmriqWXT1goRMFBA2kUcbfEkgpPnTnNhDv7LkvgQlCwWTkQU2rbFXJoZgUnQFZYxKN6/NAxWo/j6doFPYFC59W7n0y3f92mWtq0xzmM/3Yn9s6ipHb8EJTbQhFuwB+2LU5tmA8NgpKFUjgUqQWx9GhUwjdOCRO4OOeqH2XWmX8XerhWe0LSQPN5yAmuYbw+Hk9RSLr8HsT7QsI89rQjxbeXL45XbnRic5DRA/3FfXlLD8gF38cE4KxyayaUcK1//mf97yjTSvWmwyhz96Z93g7SCKxG68jX6j16V/gVr6yRNCv+k35Bwclo1MDfb7m/hl1QVP08KuQS51rqMzzngEA/e7+Sq5QWvoKP+uahAF/Ae4tVRDvEHhlPgZ200EIaAcWRHtDm5CRQqNHveD6MjhMsgIZmYB41DE77hlyV/wKaHGf8x8HvY94vRv9zk/RIqw1YX4nYLLGEGXyVhseA9Dlmrz7RO3xalTneLfuNzHbgYCeu+KBheB9Kg9mFUSFeq5sLLw56D3OuK6c4iV5NMZYkwQX7/S+c/G/LrDzoPoRUsXO0lWmEED25wYlvzVXTNM+AhZI/QkhS0e8q0ezATrOMsddVujSMtF9AX1aCIrxr4HTU/D/SLAnuH5I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(136003)(376002)(346002)(83380400001)(38070700005)(38100700002)(122000001)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(54906003)(37006003)(6636002)(316002)(2906002)(8936002)(6862004)(5660300002)(53546011)(6506007)(6512007)(26005)(186003)(2616005)(71200400001)(41300700001)(478600001)(6486002)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yfc0mLXHXPUqYV0eAmE9flcow7CTHqC3Ci8mWglKfUYU5jhceERD8qsUy4RR?=
 =?us-ascii?Q?sBHyb6V1RoqKhqEPMHy6xctkF4fAVPRaARg545zh+ZC6EaiomZQEIkO1IhvW?=
 =?us-ascii?Q?lWIvsTx00tcl9m7GXqxsnd5cRanWkTc+siWrgLy/lit2BUIzkuWeoqOg5FZF?=
 =?us-ascii?Q?RnSdrEErwZiNfXruppPnWB0F5xoc5xD9NKaa6adGMoJVdz0AZD2QKSmHdBte?=
 =?us-ascii?Q?aiJXI3LmCt89PcT7nFizvSWHqd9sh92QAhsD5gjlaQlnEhqlw6hTR8pGPr8h?=
 =?us-ascii?Q?nXyPFCGtwPQghOGC1sgWHndIOkAZTRq0X9JWdqsMquyFFegA7E78515Ef3dq?=
 =?us-ascii?Q?+TzMLtfKc7I6R3oqhajEWqPaDmk23GIb4uDru3tZRV38eqrAMJ6lfK7fVitc?=
 =?us-ascii?Q?mWdFnr1P7KJoK2RbeIIR4+aNYfMGxuvnPeMwPVJCktqe7yPSSbqdSDS4U7CY?=
 =?us-ascii?Q?ZQJsrraICLwH9AIKKieybeZoQ3qaNH+BHv1vr2rR9m7yialwt/TLygtnqjnJ?=
 =?us-ascii?Q?vaKZq9XAT0lOHsOMoGVSOtkVzvcmfdqvr3Yul5S5bH4rwEzZY227Hwqq7k3w?=
 =?us-ascii?Q?7zMEHIpInzbWn5kwRLh9ENam/k/yXsZNQbTwEbq9mZbVVnFT22/ZeiPpoMzv?=
 =?us-ascii?Q?TG4zqihC7ZDPiSQfYPpseSXxN7UWC68D8Ip9T2+kplk66o5OKBExP7U6gnzA?=
 =?us-ascii?Q?s3cg2GJoiB2Z7HWCyKJN3C29aUm/KaqfgXMqly+BYx/B7iJVXgSjORqzGmUq?=
 =?us-ascii?Q?Zm/wbHR5OFkF2SnCrueuWwPsiteZw5NPqyOjqT1sZHpRuM7srmN7T8cbyVBm?=
 =?us-ascii?Q?XQsZAGWslO3GZPjMRAaQ9qpEQ/cVrJoVXwgcYkD9NpwgqsP5WwEd2+k4spOP?=
 =?us-ascii?Q?7Nse6vkgtXs7jLUvUfezWkd9FVuxxeDcOJ5beUVLygdQJ04eu4Ne11VaRLZ4?=
 =?us-ascii?Q?lFa4c8nkdCX+umG9B0dfOQ/3051RxNbm3eV0Kb8ILsqffbO7OTfjGtiOktRQ?=
 =?us-ascii?Q?lwnDymXYLdyW6DwaWKh5tMUiC4R8IgRb4GhPWt34zup1j/NTUjnEfDniqm3L?=
 =?us-ascii?Q?kO/shGTfaOBHN8VI4EUv0ucoIShDM9xlyuTgruHsdMKXQ5SUtG91B+D+Xa+9?=
 =?us-ascii?Q?urY53kELqU6AIn5Wk6xobtrvagZNAyThWZaSHUF2QW+vumft2DPiKgBu8PkM?=
 =?us-ascii?Q?GKY86/m7igiDQunL0yrM9aCzQCwiMWQkK7irdxqC9czYCR85v0I0Bk/WB+Lq?=
 =?us-ascii?Q?b0PwLD3CBlQKh60kJIb3qBKx2cJesAJfHI5NSVafq3IUbnlmyqjj/2M8ZFGK?=
 =?us-ascii?Q?qXTrlBqNFm6lUwRauD97DdGbarfGRHGUg7yAiisB5R/wl0VKdRxLeH+kQGWm?=
 =?us-ascii?Q?EV6+FddcAbMCC1cILNcSWf+g+yLNIhF834zHPhDHeX4Thj0DaWGbjFJ0HwVh?=
 =?us-ascii?Q?I+4VaMQWyiKsEAU41NRVJi8g7zaxNtN5yxvBk3odj+o0b3V4QEusJiF52HKH?=
 =?us-ascii?Q?z8IgdPnIUYl3K8mKNHHbU8a9JmMHggZi+SvNh5G9ikoLx0jczaZUFyw65MbK?=
 =?us-ascii?Q?4tK+BGUe5m0YWs8085TT9zJKlwWhEcdVVyHqnlreRI1124SnBqPkrO5t031O?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <220F6451065F0A49BC928FACCBB767B4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2aa895-b51c-4202-42e7-08da8c9c14ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 04:32:01.5408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIdSCo+379e/vT69dnujcQOWQWUl9GNfsbriwp+h5bV8AVTGih9rfGP50Yaycosbjy1FAIOPc23VM5uiRxXoeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020019
X-Proofpoint-ORIG-GUID: 0KUqDyr1XHzJXEXxUauCYRvD4IDNson-
X-Proofpoint-GUID: 0KUqDyr1XHzJXEXxUauCYRvD4IDNson-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2022, at 9:56 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi Chuck,
>=20
> On 8/31/22 7:30 AM, Chuck Lever III wrote:
>>> 	struct list_head *pos, *next;
>>> 	struct nfs4_client *clp;
>>>=20
>>> -	maxreap =3D (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_cl=
ients) ?
>>> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
>>> +	cb_cnt =3D atomic_read(&nn->nfsd_client_shrinker_cb_count);
>>> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients ||
>>> +							cb_cnt) {
>>> +		maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
>>> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>>> +	}
>> I'm not terribly happy with this, but I don't have a better suggestion
>> at the moment. Let me think about it.
>=20
> Do you have any suggestion to improve this, I want to incorporate it
> before sending out v5?

Let's consider some broad outlines...

With regards to parametrizing the reaplist behavior, you want
a normal laundromat run to reap zero or more courtesy clients.
You want a shrinker laundromat run to reap more than zero. I
think you want a minreap variable as well as a maxreap variable
in there to control how the reaplist is built. Making @minreap
a function parameter rather than a global atomic would be a
plus for me, but maybe that's not practical.

But I would prefer a more straightforward approach overall. The
proposed approach seems tricky and brittle, and needs a lot of
explaining to understand. Other subsystems seem to get away with
something simpler.

Can nfsd_courtesy_client_count() simply reduce
nn->nfs4_max_clients, kick the laundromat, and then return 0?
Then get rid of nfsd_courtesy_client_scan().

Or, nfsd_courtesy_client_count() could return
nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
then look something like this:

	if ((sc->gfp_mask & GFP_KERNEL) !=3D GFP_KERNEL)
		return SHRINK_STOP;

	nfsd_get_client_reaplist(nn, reaplist, lt);
	list_for_each_safe(pos, next, &reaplist) {
		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
		trace_nfsd_clid_purged(&clp->cl_clientid);
		list_del_init(&clp->cl_lru);
		expire_client(clp);
		count++;
	}
	return count;

Obviously you would need to refactor common code into helper
functions.

--
Chuck Lever

