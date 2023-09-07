Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6CE797A3E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Sep 2023 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbjIGRev (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Sep 2023 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242677AbjIGReu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Sep 2023 13:34:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A831739
        for <linux-nfs@vger.kernel.org>; Thu,  7 Sep 2023 10:34:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387FYTVA023307;
        Thu, 7 Sep 2023 15:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GLUF7AF4vTk1IPqeH6eL48yBrASqTPeawXqS3wjUv0k=;
 b=BuZvM+s/3ZYS5BxPeGVRE/Lnow6STNk7sciAONkCQitxQuQcC8vdBmh5uExnGyGUmdMa
 9pOQ/wE8F9Do4Vwxguu+luZR+a35X3/CadTSvh/6G4IzPrvNBDuXVAn73gVYtaULO9On
 1AewJT4dV4f4HMexlrnXqwnqZ+OZj9kffVoZKc320Eo2RzdL+LVmgkQ0WN+elvvvfVao
 rtGsEsbE+US8nLy3Dmy4PqgR5TLUdxGduEgUMhOIh22JjtR0ky0Q7TnLKW2wrZc9eWxN
 +CtKuFtkJ2NJy5xtfgvwv2smGTo5oAi8UX0BkpR2+JcaHHy3QU/xuGD4DMc/wehxlfUH hA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syh97g0ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 15:40:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387E4K4q004465;
        Thu, 7 Sep 2023 15:39:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug7v42k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 15:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY8xUiBxQfKKek+IOjaaRi1Wkhf43u9blmlg4S3UHWXXTMZRTZwjwhFNreRvdw35gfenkB6QeCDAknqDkvZFvVgex8al7kcbXSqIH43PLH5mT/qFNiutbx1PFdApU3tWutYG2zuULtm536ELGayu+pa3wLJTV+Xnwh/wRy92Cs3EsTyT833Aac33xeKLfodzrM6VCLXm9V+KQHE2JlyZZHRQE27ulwlFpmO2A8BqvcHidGlmZs6C/ZQGCe/nVGq1UFDncO6QDuW3/JjRBpwykkxoQgUPuixXFs40uabh9EACPck5zmbj3Wg/3rNIPbOq454boVhZV/1fgMSBn0TuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLUF7AF4vTk1IPqeH6eL48yBrASqTPeawXqS3wjUv0k=;
 b=ApN3p2nM0WBflv0YeJPS4pvMsB/Qa4LQ2HzY0nxC5CN2mk38+DrwBo2YUIoax3IVzMHdqzsRnsVwaEP14xVbtm2naGaq5i4s0anlLQUxZ6V9B/wSDXPQ3uJJGH6/+qJEAWg1rrFw+MkfeN18kfeKhdQmtj/2+cnPGDbyE0+olFzAtwT2nAX0Ka0/tX7AXh4qw4I2Xljj6iohOIR/dYHZSCKLTtp/SWQ6tHEc/dPmkXx7HJxMa2bFElhkc47kkcHh09SzhuZBAwF0WkNgGRk1vwIWpdVe10YvPuYX7REZP9Uyw/gAs1ZHRql7bz9XgENfjNnL1wSy4XchBs5GyMii+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLUF7AF4vTk1IPqeH6eL48yBrASqTPeawXqS3wjUv0k=;
 b=rgKoleom+/dLQKcasNboBKlJp5EF6LaRb0ZV+1VgkW20oAB8bkQJ9RIUqBNgla8j2ySyTpoenLIiMs53h9Ca1UI7a3FAS3csYuvar7tNziVVL91NUjSTh738iKVoMzr5FebtpNE2dRrpQzcHid/gD4irs8jw8vTLTW6ZObH/79s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 15:39:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:39:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG_ON() hit in sunrpc
Thread-Topic: BUG_ON() hit in sunrpc
Thread-Index: AQHZ4AjglDLFb5i35EOVcVfzT1/0ErAMU4uAgAMvPIA=
Date:   Thu, 7 Sep 2023 15:39:11 +0000
Message-ID: <0B563F93-A30A-4BFD-BBAE-F712F8011E04@oracle.com>
References: <20230905-netzzugang-kubikmeter-6437d53204a2@brauner>
 <615A8DB3-F931-4EFC-A6EC-CC4DA3766D7A@oracle.com>
In-Reply-To: <615A8DB3-F931-4EFC-A6EC-CC4DA3766D7A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5186:EE_
x-ms-office365-filtering-correlation-id: fbdf05fa-01de-4d57-4016-08dbafb8956f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ds60uODqSn+pz00bNKcNpXtAqMpKG6f1td2H6/EXWWY2eMhLNI84skLC924pl8XS33I7QoRUAeW9yeU4bR46ZwqhjkSlk6RKvaLkeWd2lY7xcs/DwmMw/XF2ioo7V4CYF083HpjaMYB3DGQNi36sKJMQIrqItuyrlfj0XRk8RA1YiR7wv7sKNjnuEpm3bbk4qwg9xS5uj4DD5lZTMCc8QXL5gpgjLciCuIqZaVaNiumXLQLJaKlqxXCk9DnGOYCKDjtKUjIurkIkuDMoAx+IgEd/j5xeC/6Gvi0DLNjEY8zxkCf65OwnbwW8ZFBrQ92m92ATPQyL+zIDgTIbN9+1igVfiaSxGVZu0Dn8FIVzMwRjLsE4U230cNGFoFU5h8pih5ueS/eJzOFNiq35AO4A7kymAIQLjwGNcpXQ546Vd4jetALqASH66+UMDFmiTWYvhDiRjRAlTiI0+/DNLFctr+4/EinL6IGJ9MJJqMAb2Lza6N8OpvGkn/hTr7PvfPKo3+5jOTEcYMUritLymxlRbO6CnT8Yl58dpG1r1GmhXwxbZIAvsbVIK22OAbw1wW3NUs17Pydvt2zGTlZIW1ATlm0MOb24FbfTrbBCC78UwF6cWDXnZsGkR6OHZ+RJW+bufabLhW/cTJlJaoZBnJIQdGdEYV+SOSEcenXpezSs2gyiy9ACf+CBG/A29iVll2J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(6486002)(6506007)(53546011)(71200400001)(6512007)(478600001)(83380400001)(2616005)(26005)(2906002)(6916009)(66946007)(54906003)(64756008)(66476007)(66556008)(76116006)(91956017)(41300700001)(5660300002)(66446008)(316002)(4326008)(8676002)(8936002)(33656002)(36756003)(86362001)(38070700005)(38100700002)(122000001)(45980500001)(1758585002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TIxpRxI8LHLejUV65CH9j7nnbKQ/0E6PhgIgiwjtMqnZJgl09Mfenmj/y184?=
 =?us-ascii?Q?Ose0u5jeZ4yvin6kiz9NjTRit+flb5+qMaCJ//W6s7K3+bV5pjFIe9em8vRt?=
 =?us-ascii?Q?yrocqj3uwG03khScI79RVh/1hJ4pacU+CZxeeHdtof7DfidGtAkn85wwxp7g?=
 =?us-ascii?Q?A8sfedVUUOZ/9rsYRAAZA9ItmFiAx0H5WHa6DljfZ3ZkC6AEm9hlc9HMCaYu?=
 =?us-ascii?Q?gceIa1DKgL3LwqEKU8NJsZeru/JSMZqrepwy+Kaipj31UiLErenCdRgTjk2X?=
 =?us-ascii?Q?nWD9KGmKMoC1lxOGkSl4Q8d1lEZEb0SPozjarecYt0ADufPLwyvhBuWE4IKD?=
 =?us-ascii?Q?pN6oT7WrEnhP1Wjza6QnHdEF1mtLrBFLOiR+0fk/DQdUNakhLWpohUh9QRiA?=
 =?us-ascii?Q?AFh2ea9Blbpy0eenvmOSxP3vG5BaibIRtMZtSHOLjKJR8RO5qDQC8lchU7uV?=
 =?us-ascii?Q?lioWTkT7VTL6cNfovJgejGIP6EdpsRA9Dz1y04QcmzwvVIC6WtwRds2FP4qj?=
 =?us-ascii?Q?tPwF5RKmFT/hLbbL7FkTnLQ1RwCCxtYGmaInyx255i0uIa6/EmcuXWoHi0mS?=
 =?us-ascii?Q?zC0SSHF6zcAu5/qG3RVT4PKXTeicJ1awytkGHHlSfHDVESCtpTXV2pkg2IjF?=
 =?us-ascii?Q?CEbO1+/yyAVn0m4z1xEs+cECzPjaRfRt40GMpQYoeMbucifD09kLgn55M2r3?=
 =?us-ascii?Q?IdGF/rMyTXHLO7C/ZuLrg6NnGPETxvc5TVh127mNRa9MjPXXj8uHjuOtEVRW?=
 =?us-ascii?Q?eWgACjNLjUtBxCAYR7VBiRDgfLnRnf6CeEboqOi3aQagC8JVRjz4yoZmhLHP?=
 =?us-ascii?Q?iV9GWXViOZml7QKeJVZBDhKSaE2eBaH8yh03EJoSciT0vJHylGrwR7BS4fHz?=
 =?us-ascii?Q?Iq7RTISsw84imvC24lJxbRS/TtFdheehC9hcg2uLCP73inNjB5MQUVxzMmc/?=
 =?us-ascii?Q?blsBwn5LIgAtNcEum0Aj0oLCxxeFmAP21tdjxdjBlWZjGoGp4KIuURGid1rG?=
 =?us-ascii?Q?53S+RP/Af1KU57CLCgpVWVjSTPl9sM0GW4OxeHBj6ulD4bBmWd6rCvg1GkRG?=
 =?us-ascii?Q?BkQbvvIZPCzR9iKnBicHhvTWxT/fVbnHeyXoaVguSU3C0Ck8U86Kwddorst/?=
 =?us-ascii?Q?kfjmqmho+LN5ozs8cr1m8bpAidJFHwhKgklSWcavgseNzxc/RYxc/SxbpnHC?=
 =?us-ascii?Q?to5ssHvFQ4Ky5pidLxwANTAKD/yrs4XM7K7lvGc66Lz3T+HLqZjIvWAqNOlw?=
 =?us-ascii?Q?nUEQmcsHyl848aH1Xk8aoiJSeSY9Vo9a5is0ax8KmAUXq5A25e9romm0+BZ4?=
 =?us-ascii?Q?ZIVxVnI8tuRi9j3Nm31UTYfMwnwoK4aB73mQ5AUX4D0GbIPaL3jxq4ikQZem?=
 =?us-ascii?Q?faUjpyM9jyI65cMWd/Vpn7TxWVy8c0oYWFBueWzzf+p/EI86qCh7pCT7bUCy?=
 =?us-ascii?Q?7TTYAy3x2AMi8uSqbQRCufVJLcFPzjmMrEZRf49ce3cHbV8aXgpZv53RJGiQ?=
 =?us-ascii?Q?J6zK1ZucmnE25QeebcJOC67ALl1/V+vsMEtramFjPg2xuUC/NAXqdVKdl2D3?=
 =?us-ascii?Q?US6F0BNEY0L9/Kpu3FdgtrOBu++GsZ1s1RPrDj5ewoIkaGCZxMzqoGP30PSj?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB6F4394B7E3C2429A793329135BFEEF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i7/eTlUdFje/raMuty96iizC+sTLX45Hy8+jKZ0H2yPBSt8Mq8Jpkagau2oM7y+lq8f8yQLelYH14B/9ul59sWUZX5TQusRsdD4loblwjGMS/kbdNjyj8HKpohqnMQ7UxeoZU9J34EoKCFyyrkr3pf2+nvMlMMMhfOwbJ4SNqXM24oYrBd9wJ9yapSCv4Ogx4BtxeiQFd3NyD4j9TrpuAhEu5WYLY5hAudvFRegqhVk8MvfX4DGsXZ6BgAiyewjYe76ifqygW8RStlvdfJi2MV/WpA/YR9WvI58Bew3nsdTQ9wzIqBlz+CidefqqVSYQKFQ/P/Rzn5o9r4oEIhmhqd04hGMIILIhlqBYAVd6fokdrwP4Q9DoXdts/RzjILb1JV/CS4LyIhhyOsFh8FgDi/t1NK225i6XTaCfu5FbN8pan2W86YKVjsGiwwOz6IUPUxoP8Z/wfSKjMPWkQjym5dBn2xHtVAwyePv+jWtZLIw9rsyrVwoGGkMPIPEnLtGzvP8pfNwDDo1JFN66bonboq/sxCiH9QxsLbA6BNE0CxTZ+YGYIhq0ndRFc283ZJUV2HUB+tY1wtqng4PGGD8HpLmYs0bbeLKjxNpTsirV7Qywcvo/P3bVlwK1DiiqAssHYS1e7fk3IdN3Yhg+Yqvr8I5iR5W3KWUHmxMKBzYufJajl6quNMCQI0GZqchdW5rIUSxUXyNGj7lnwJiyolNe92VSmRHY6wtab5tCp8WXzcEciR0loLLFEtOYXdXBCnKZW5zRj4aJN17A/K+5f+Wsaj2e4cdBpavJsPuke7SKaKim+qHkmUM6r4IcgdHIL0TU
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdf05fa-01de-4d57-4016-08dbafb8956f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 15:39:11.8414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUfHEQ4NSdrJFD8l5Fo6kFYENRCRQDJSXiDtW/gk2ku60BmildQ5LiUAC2ZHwtKv+CECpwUU5XsQX8iaA34Qqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=777 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070139
X-Proofpoint-GUID: z6QBaUf_NRUldXTOxQ_QU0sh4tbafLdy
X-Proofpoint-ORIG-GUID: z6QBaUf_NRUldXTOxQ_QU0sh4tbafLdy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 5, 2023, at 11:01 AM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>> On Sep 5, 2023, at 10:54 AM, Christian Brauner <brauner@kernel.org> wrot=
e:
>>=20
>> Hey,
>>=20
>> I just tried to test some changes which had commit
>> 99d99825fc07 ("Merge tag 'nfs-for-6.6-1' of git://git.linux-nfs.org/proj=
ects/anna/linux-nfs")
>> as base and when I booted with the appended config I saw a splat right a=
t boot:
>>=20
>> [   92.804377][ T5306] kernel BUG at net/sunrpc/svc.c:581!
>> [   92.811194][ T5306] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> [   92.821472][ T5306] CPU: 6 PID: 5306 Comm: rpc.nfsd Tainted: G
>> [   92.828578][ T5306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009=
)/LXD, BIOS unknown 2/2/2022
>> [   92.836319][ T5306] RIP: 0010:svc_destroy+0x206/0x270
>> [   92.852006][ T5306] Code: 72 49 8b bc 24 a0 00 00 00 e8 a6 a3 5e f8 4=
8 8b 3c 24 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8f a3 5e f8 e8 aa d=
f 1c f8 <0f> 0b e8 a3 df 1c f8 0f 0b 4c 89 ff e8 39 03 79 f8 e9 ae fe ff ff
>> [   92.867075][ T5306] RSP: 0018:ffffc9000a347b60 EFLAGS: 00010293
>> [   92.872714][ T5306] RAX: 0000000000000000 RBX: ffff88813abf5c68 RCX: =
0000000000000000
>> [   92.884809][ T5306] RDX: ffff888126c38000 RSI: ffffffff896bcf46 RDI: =
0000000000000005
>> [   92.894190][ T5306] RBP: 00000000fffffff4 R08: 0000000000000005 R09: =
0000000000000000
>> [   92.900512][ T5306] R10: 0000000000000000 R11: 0000000000000000 R12: =
ffff88813abf5c50
>> [   92.907935][ T5306] R13: ffff88813abf5c50 R14: ffff88813abf5c00 R15: =
ffff8881183c8000
>> [   92.917264][ T5306] FS:  00007fabf0bba740(0000) GS:ffff8883a9100000(0=
000) knlGS:0000000000000000
>> [   92.924880][ T5306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   92.930358][ T5306] CR2: 00005568a27d60e8 CR3: 00000001737c3000 CR4: =
0000000000750ee0
>> [   92.937465][ T5306] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>> [   92.943057][ T5306] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>> [   92.948673][ T5306] PKRU: 55555554
>> [   92.953452][ T5306] Call Trace:
>> [   92.958082][ T5306]  <TASK>
>> [   92.962546][ T5306]  ? show_regs+0x94/0xa0
>> [   92.967221][ T5306]  ? die+0x3b/0xb0
>> [   92.971702][ T5306]  ? do_trap+0x231/0x410
>> [   92.976275][ T5306]  ? svc_destroy+0x206/0x270
>> [   92.980717][ T5306]  ? do_error_trap+0xf9/0x230
>> [   92.985287][ T5306]  ? svc_destroy+0x206/0x270
>> [   92.989693][ T5306]  ? handle_invalid_op+0x34/0x40
>> [   92.994044][ T5306]  ? svc_destroy+0x206/0x270
>> [   92.998317][ T5306]  ? exc_invalid_op+0x2d/0x40
>> [   93.002503][ T5306]  ? asm_exc_invalid_op+0x1a/0x20
>> [   93.006701][ T5306]  ? svc_destroy+0x206/0x270
>> [   93.010766][ T5306]  ? svc_destroy+0x206/0x270
>> [   93.014727][ T5306]  nfsd_svc+0x6d4/0xac0
>> [   93.018510][ T5306]  write_threads+0x296/0x4e0
>> [   93.022298][ T5306]  ? write_filehandle+0x760/0x760
>> [   93.026072][ T5306]  ? simple_transaction_get+0xf8/0x140
>> [   93.029819][ T5306]  ? preempt_count_sub+0x150/0x150
>> [   93.033456][ T5306]  ? do_raw_spin_lock+0x133/0x2c0
>> [   93.037013][ T5306]  ? _copy_from_user+0x5d/0xf0
>> [   93.040385][ T5306]  ? write_filehandle+0x760/0x760
>> [   93.043610][ T5306]  nfsctl_transaction_write+0x100/0x180
>> [   93.046900][ T5306]  vfs_write+0x2a9/0xe40
>> [   93.049930][ T5306]  ? export_features_open+0x60/0x60
>> [   93.053124][ T5306]  ? kernel_write+0x6c0/0x6c0
>> [   93.056116][ T5306]  ? do_sys_openat2+0xb6/0x1e0
>> [   93.059167][ T5306]  ? build_open_flags+0x690/0x690
>> [   93.062197][ T5306]  ? __fget_light+0x201/0x270
>> [   93.065020][ T5306]  ksys_write+0x134/0x260
>> [   93.067775][ T5306]  ? __ia32_sys_read+0xb0/0xb0
>> [   93.070501][ T5306]  ? rcu_is_watching+0x12/0xb0
>> [   93.073073][ T5306]  ? trace_irq_enable.constprop.0+0xd0/0x100
>> [   93.075937][ T5306]  do_syscall_64+0x38/0xb0
>> [   93.078394][ T5306]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>=20
>> I haven't spent time debugging this further. Maybe you see the issue rig=
ht
>> away.
>=20
> I don't, unfortunately. A bisect would be appropriate.
>=20
> I will pull today's master branch and see if I can reproduce.

I wasn't able to reproduce this with yesterday's master. I don't
recall anything in Anna's NFS client PR that might account for
this crash.

Neil, I think you were the last person to touch the code in and
around svc_destroy(). Can you have a look at this?


>> This problem is only happening after the nfs merges afaict. I'm
>> currently using commit 3ef96fcfd50b ("Merge tag 'ext4_for_linus-6.6-rc1'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4") as base
>> and that splat doesn't appear.
>>=20
>> Hopefully this is not a red herring.
>> Christian
>> <.config.txt>
>=20
> --
> Chuck Lever


--
Chuck Lever


