Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22021682067
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 01:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjAaAKu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Jan 2023 19:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAaAKt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Jan 2023 19:10:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FFF1A94C
        for <linux-nfs@vger.kernel.org>; Mon, 30 Jan 2023 16:10:47 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UMiD3E007408;
        Tue, 31 Jan 2023 00:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9ZfMQiRY2SSPiDww41EpJWs8FiZ1pqco5uiJ5kav+tU=;
 b=wp06dS8YH+BYmpLLJeUvb7Cqqme62GWMdCZl4+5P/gmE1n8EI3AyLpNOalLWlfYJWyT9
 5N6OJtoU/LHxtKm5lbiEhDqpPznw76TqvXdwUobW0VHw5TkFjyG/WgVexs5h9FhMQpe1
 zEqnVhKonzYuTVKDbxqvkZfrWZOKZzx02BLyIWDm70Gqe3zsGD9UvNmQ2DbHAZGU/wdL
 bgdg3GJa1SGmDVtS4LPziL3z9tIuFDKdPuYm/4R1vUzC7PCLtDFGZrwhxUcWPqu0KrGv
 HTHJ0/cb+KENhqfcyMz3GqtRdlbpXSVNTrFTK7q50iompJ9xslHhGjdBqAjhSsooxtbM Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvq9mb32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 00:10:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30V0A0RI020384;
        Tue, 31 Jan 2023 00:10:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5bmv5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 00:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhVneoiCm/ustyrPcWrtY5dxuy1EsrtHEb1jhCb2sVzQjite/2ilyaYwFjXyfaP+RdnpOKssqBLpSS2JGZngfgx9D4GOqNOVkS7MPROkhon70VTprD09s6MDZhTnSoBW4bR3Hg6/yxZv5lZauroVYQCg/7oNFa1p47fa+d1CJXESW0NumqnLj1cyVTNWrp199wbTiBMQ3IhTpW4K/KMW71Ip6tCMDbLVYksy8UREJBmdacHUnl1orTmzol/jlHFwuV0E135va8mMKQ/JNo7JQjatikvMrbe132E2dLrdjajFiBBip1J1q4dDg2FAhG1ZV+y+55OgeTJfjYPGxjniug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZfMQiRY2SSPiDww41EpJWs8FiZ1pqco5uiJ5kav+tU=;
 b=GTKUcRulSsCes+9ytoIfhUs1tH+Yq8cT+4gAgC9Jmx8hUz2e1DwPpjzmckTg/sqDPIU7Lr1izwZQ300u+VXev5ZJ+ucGH+lzEYWzveyBO9eBPA3KapEZ39ti3vVr/o/iwMIccSlij2khxZaVgRZxnD2N5L2qJP3ZMr4OSWa5zF9JWYEoUblygbb2mb2k87jbPJkCuEbTj8LTduX5RRi2lm6mXfwQ6HJTpnOG/N+2f1f+kcKb9iF/NctzHhzLPu2ltAffhvE5feRWZMQ5Drvi1e365OfGaUWVAlxPvDCvoyMHRMj9zo+d3B9U+pLK3TMO5lXC6DvQr4lCwuAjEQdauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZfMQiRY2SSPiDww41EpJWs8FiZ1pqco5uiJ5kav+tU=;
 b=ZZSzEPAGPxZ3G6Zmjzou8pS9FPnqZX5taYmM5fRDXTh6ovBJXkV1LjdtgLcGqI0/kN17Eg2S1+UwJJvfo6EWXqa6TKK58yEa3a3Ve+AmFT0sd2+9d55gVOU7QYEcnqcGJX+vmeTFa12XnPig4EtBWx7hhlB/erXusIdGGBMGApM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Tue, 31 Jan
 2023 00:10:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%6]) with mapi id 15.20.6064.021; Tue, 31 Jan 2023
 00:10:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Andrew J. Romero" <romero@fnal.gov>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Zombie / Orphan open files 
Thread-Topic: Zombie / Orphan open files 
Thread-Index: AQHZNPfk4CJ0DwDhNkGXE9jEOOJtYK63pvcA
Date:   Tue, 31 Jan 2023 00:10:41 +0000
Message-ID: <0D998626-5934-47B1-BAC5-3D044FAB4926@oracle.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6432:EE_
x-ms-office365-filtering-correlation-id: b4f9de63-4847-4373-44d3-08db031f96fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpRAaNj2xsySGAE/AjUTSVo4TsoML2bvkkzvOT0l3ARRHRPctQQYT4k8rkni3zR9A4mkmN2E4rKQUwZSSaF+b1d0R7RDq/taE0LOUBapeWY8Sg1NZ22lbv5wpSKdsDeh5ZrUGj2tLzMoanMKdNYKsawA3EURl+EgIX45TySfOz/RJU7Vt4iliFK3RUTad7/Kn0MREVEwZDnwPPvo+QhCtArFpk6t5mFtHZcK1yi/FXfMsyTbBddCCQTsmBwkSNwDBsQKKtBBxG6g4nQ+n1XxZc61eJ/bGWNGc3+6VDJ+0TAJqupw1UPPhfLKljSr0MOZkOibnEj/T3XsHp/zoprvtnScPmLYxV/2Irza1Fi++rUvyaB6omd6AaUNXIPCBpi1G1PLbt0DXvLndIzOgcE9/9lt70i+HfqFr1QqbApV1L2yKVZqVHLP5LOPeyum1RBaSsjtU8bduvSk3mdHliPQcfnhSt9BAviVW2Zrd14mNJqxaqgz+J2+24Q12pZ4o/7Kw1FlZv4Cpq64B9bPAiyH5zCzKRpaX7FJKgV5Tlo7XWgVPzc1eyrHUYn3huVRiRCB5wx1+jQPQTTVM+17yuGzy2aFSGRzwyqewq0TaaVLS4cnDGikYqwstLISs5pvRCdEVN5rQ3A9YnNl/nl37P9CGGJlZwEQCaptpgS5k757Fo33qJpD6antP+VMmwobBQdE6jr2YWR11dBAedJ5tHjA+8wmqfNJ1m68uktZ2w2nwDo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(6512007)(186003)(4743002)(26005)(53546011)(6506007)(83380400001)(38070700005)(33656002)(86362001)(122000001)(36756003)(38100700002)(2616005)(8936002)(41300700001)(2906002)(5660300002)(66899018)(6486002)(478600001)(71200400001)(91956017)(76116006)(4326008)(316002)(6916009)(66476007)(66556008)(66946007)(64756008)(66446008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZtjPAHpIwLTYHbSO46ydDZwQg87MKpqBdwfsNcWDZsp2t1TXCobMkBCAMvlq?=
 =?us-ascii?Q?weZMZg2tCLblHBj8ZDImWeKn0Wxe7gvjzDLZ9gQAI+RmgoNTEh8cqFcwEKyA?=
 =?us-ascii?Q?gw7scbxCg7Qp+gqdGQKe8K/A7lrDIb2OQL1J7m60WNEI9YM/85Td+sevBaXH?=
 =?us-ascii?Q?kYvTPuYXttn04ohNA9HgrvNI24BEGD9FOCgvKNEV82JmCO3Kj152n6sbCoTe?=
 =?us-ascii?Q?bH4T1LG2KPy5+8IkOeLCjNlPkAxCb9i3DJjVMK0Euu+V9/IKUwa+dUsHOEfs?=
 =?us-ascii?Q?uA8P2go2ZXmyIXuoUWxBWl9boDlt9sb6cinyZlRCamtrEzATGkA8iGxS/4mr?=
 =?us-ascii?Q?Awz6CVO8Ft4H+WA7/55plYu0Ohjp4ifXLHO9OihRZdFwqo4uDqB9huaJP2ar?=
 =?us-ascii?Q?hbVUw/fnBdLYI+3jZ4DvddyDwRVK7ZnQLKuEzABNGkZM00d0x3lk7E+Ul2Q2?=
 =?us-ascii?Q?a6pabdQx3FJPLWOWhsPeMN+QZOJZSryoGxxD2cLcrNrXGD6K3tIwMuooRW54?=
 =?us-ascii?Q?s9ObJ2vR1W7a6xHSsShUZO6sSG8J4O8ZueShPe884beog++SxLUwIbA2Kq6G?=
 =?us-ascii?Q?i65TRs1CovStDq130mPNZzgpQhKpv0/Mtmu1VNI0yIXXX96P82EjC6Mgimhk?=
 =?us-ascii?Q?DmobOUJqopuY+9dtdNhWynwdzxwwP8TUEWR1dAmHDJkdbiNAK+ftgFpAkqvb?=
 =?us-ascii?Q?/5QzEt81rPHO+lCfaTerU7rF7BEWB8vcpfJgDbHEy7Jzxl9GNjhCrpXgVGKD?=
 =?us-ascii?Q?WmkcW2VXhpO/BWQtGUfDEFW4IlVL8UUmvpmlQb0K6Bj2Gl0edWY3ye/gPeVz?=
 =?us-ascii?Q?ZixhRSCgCELaH1fds1MFqxfM/m2gKufNpNjliG7L8lXC175ncxEryfzyv8c6?=
 =?us-ascii?Q?Hqx0y2V3xdid4UxVccehivMoKbKa7X/VUlkMjZD7Fu2pBsT5dz5LhqHl+l3Y?=
 =?us-ascii?Q?mahCoPrTuAQ1H10SsKeNuRyHKsrGjxEf6h9HPidWjk8VZ4LNYzxcfjlX3tF5?=
 =?us-ascii?Q?zCP5r/PZSIjROvVA6KoSs23Cf0KVt/lm3fl0zfbZZ1EgNxOk8rIuMoErb+Bu?=
 =?us-ascii?Q?t3zVYxrw1yWz8vjMJLX5uW/Lt3q5hWxgipSjdBtZKtg8+GePtE9NBHtOe2Kf?=
 =?us-ascii?Q?281fDgLKpcenj9E8GNL3jetiJq8ydBUk+p424N04rAHiXzqm3MHy/cOdVXWg?=
 =?us-ascii?Q?tF6GCZq/JM+fK6zKApo9d14qzjkawRSNtioSKmsHHx+ed1W1eegH5gDLWV4k?=
 =?us-ascii?Q?AT2p26D2hcmXvCBtSrlOsFadqMsMnum6ZXdmI0d6pJJMgm+lLGlY1+9eT8j8?=
 =?us-ascii?Q?MuVe5fV5AjCZYDbBfwqxAa1sA+LZ9JPlyl+aj3pTRkC70rWoqDzR1ZezHwvv?=
 =?us-ascii?Q?/1UumA9eL1/cnqzYt5j2UHmvTWiz3hTtqbBbHEIdtU0CQoY2aJppf7iuw2mD?=
 =?us-ascii?Q?BoD7pl96B8VaixYrMxa5qqRdbRPYd8fVi7kl7b0nLsId3EgtTnTcaWIgmm9S?=
 =?us-ascii?Q?omZYta2Ceu4VJkt1I+2OClb2RpNt5MzLCxN/IiJ1F9212/xRNdrFi12HnQUr?=
 =?us-ascii?Q?jMNXUU6w83H0LnvIrfhSxC+zLDQynpG0VPQWfjFFqwVkVCIcAje4d0YwZWVf?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A494EC53037154ABC7EAD787404883F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xwm/wkBehsHfNiZgME2EMmfF+LtzjPp4F2XP4isIdQv9ti4Pwg1GB+WaE4fhwHI0aaVa8hMiYy7cUIQIJwiOqFZdFUvYwljPXvsIjZJ+WFJ9U5KKv3n4zXlSP4XbCv/6Rj9in61TQZ6rnlhgM/QEKdu0JYdfvz7+rNKU68OWP7WoweKkytxlU0wpOJkvmO8hgkQBgyP9L4sy7EzQmd2rvy5FVTD9twaBMZMWUtyuAqS3ghy4Bbmw0FADf6nNJy2udQlvJIn3+GgvBD2NrklAJT0Bo/iaMzgDFgDttQKHg+2QM8vkxNAlCGXThWtwhR0WMW5lWt6d4/tI9YhH3c2MJ+Y4m+gSccoj1hy3eNjT4mjEqxx18ZYQ1eRVYBFZnN126rU6hRFA5faXtmA2c2UpiceHs5xpJxpQougUpnIuGbVCCgEoz7oqFHd8SZMarfAU0GSSk6ORPs2NCSvTsrmE15VQP2btHMqcqyZ8LZYJmQtu5dJi6Ewvv6qEao/1qLWKz0TobgCCcixbi/ejagnGKhpgZ+T/OQBEuwGe2FKXzyBFetRUw0vj1t2oiy6/+f7+PHZHYktRv8vLAXwZjzG0j7pK6Tnu+MDvDmPU6iH+x+itp+ZHKv7Xl7WsxWL+bkWpf8LRR0f4Y4Xi8NS36mOE0zOR2PO3PuFYMPyPMCK8vb5K0pDNfRInNzSpDAPifJi9PUnHoEV5VReLNHweYGEC1TccfkOmIsrJXdMdDVr+5idSbKwg9smETXGNObxab9kK8p9E8IQCRvV7nxLUQMLF9+Ewg6YWW9VyB5xUD7l7+Kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f9de63-4847-4373-44d3-08db031f96fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 00:10:41.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TA/Kqw1dGbUfXNTRKJIUXRec4FSFwNEvu9A2jlE9e/KWO13weYxPLuzmC2KO4yfqq0NyNo4Q+RJjPUvb0i8lfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_18,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300218
X-Proofpoint-ORIG-GUID: EgMEF5eKR03ZVRvY0jsGPmcSCsPnfbvw
X-Proofpoint-GUID: EgMEF5eKR03ZVRvY0jsGPmcSCsPnfbvw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 30, 2023, at 5:11 PM, Andrew J. Romero <romero@fnal.gov> wrote:
>=20
> Hi
>=20
> This is a quick general NFS server question.
>=20
> Does the NFSv4x  specification require or recommend that:   the NFS serve=
r, after some reasonable time,=20
> should / must close orphan / zombie open files ?

No it does not. A server is supposed to leave open state alone
if the client continues to renew its lease.

A server has some recourse, though. It can recall delegations
to free up resources. We have some patches for v6.2 that do
that.

Servers can also free state where subsequent accesses by a
client indicate that the server administrator has revoked
that state. I don't believe the spec makes any statement
about when to use this facility or how to choose state to
purge, and I'm pretty sure Linux NFSD does not implement it.

A heavyweight tool would be to simulate a server reboot to
force clients to acknowledge which state they are still
using, via state recovery.


> On several NAS platforms I have seen large numbers of orphan / zombie ope=
n files "pile up"=20
> as a result of Kerberos credential expiration.
>=20
> Does the Red Hat NFS server "deal with" orphan / zombie open files ?

Not currently, nor does the upstream server.

Purging state is not terribly good for data integrity guarantees,
and I'm not sure how the server would make fair choices about
what OPEN stateids to purge.

So before going down that path I would like to see if the file
leakage might be the result of aberrant client behavior, and
try to address the issue from that side first. Do you have a
simple reproducer for this issue? How do you observe the
orphaned files?

--
Chuck Lever



