Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7051589E9A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiHDPXx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbiHDPXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 11:23:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5251A36
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 08:23:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274FFwMo007542;
        Thu, 4 Aug 2022 15:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=J6PWUu96OZqsZqyxC1lanLOaHbL+Bvv6X23WoXXErew=;
 b=Mu05k0eARgUZP0kfUCLi/8/GzC+7RLN+aJZ2RBNpXs6PucjxHc7TZ++6wkkAUPT3RYdM
 Yutccnz/Tuoo235s4bpLjKG0a92yP4Sad7an4rMF9RxXTm1OpGm/p8CiluNHfOGCIQ/4
 ucoXHDZIRJH+da9K/aEkpblAP2UwVvTqAbNwSi4DvsuQizHvUpSDMX19xPMLM13DH1B+
 dL70iXTIyhAVIZ8yOSoIF1Kqd/9aNOy/lJTgd98z1wfIJ/0CHsu6ttQXxd1kBg6UJYlo
 ykja1XCTEsZ6AM61hlIFZw/wMAH+w8Laq1cIzSClv5cMVwqwujN2JajLHAzGvhhbWQ0p Cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu81581g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 15:23:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 274D1mld001056;
        Thu, 4 Aug 2022 15:23:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57t8rrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 15:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE24ny1UEcaODAvtVj6zeLH+NAQYRFocHGi55wmIz8zBdPPND61ZyE3xAiLY1VSdMdeNziNGTBAtbqUYmTfhGq8p5tjjdKiujZCT/YYdModvq9JZnayy5c+ERZqg6UxwFUU/DQXWp39wb3tpPCEooCT2FNQOC646z3yCgkqSUTXZoaw8ONDPE1lUJDpV5VHFZrKBIOr0T2fuuX6+th9VLik2EDl6RcVVxkYWcN1NOcqKm3NkFyGMy1Ko3IJAy5RdHD8U9XxzgcmBMHTkUOuVjF6j0G8JVsyR09nuQSeZQP0v1HaNylSZ63kB+uNHDeEIfvd3WeOP51ItFldDLhGShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6PWUu96OZqsZqyxC1lanLOaHbL+Bvv6X23WoXXErew=;
 b=i+cK4QuNqt6n7+9B22G6TCwT8XN2DyewVM0zzsmaQH2pO/RxeDGx4gL9j2lDxzxEowCilJP1kFdxgeH3NrLujAcu/x0VyHhoSs1WbXl2FtIcdDtENkMTqRR/uz8/9W2XNNwGzg2DZskpUGzJQyPn9JAnNmWx174X8Pi0DXBUJigLf14nfofZXSYVY2txjZTB4bZoWF4F18/DOqn64q71085r9qgSwsolP8RXhfUGOMXGtZhS84xNQsNvOT1zeh74Ax1qPqIAMW4dvMxMq6rofkXFWDpESPNZmCUoR4XEEIrb2eXqr69mWEirJBlRGbseO97d371RpYSdRmgHP/Uu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6PWUu96OZqsZqyxC1lanLOaHbL+Bvv6X23WoXXErew=;
 b=YXkDRzwJPP7tFZ2PShD61L3605GA0Yvp6QH64ZMmUo7K2HLYPoDI+2JLgGVqcaP04BTtJZv9jWo0be7GjSUKdOfsUexbx1ge9aeTlfB50bb7dLikHnGWj7afgcCUAtkfYDkUveZX0jXauqq7sOyxuf3bqZD0effVHEQXiI0xI68=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM6PR10MB3244.namprd10.prod.outlook.com (2603:10b6:5:1a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 15:23:45 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 15:23:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: pynfs clean_init issue
Thread-Topic: pynfs clean_init issue
Thread-Index: AQHYqBYv/t9veUBiB0yDXt264gjwFQ==
Date:   Thu, 4 Aug 2022 15:23:44 +0000
Message-ID: <F80796C9-DFCE-4C7A-A2EE-4EB2075B9007@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0464478-3234-4ee6-1046-08da762d51f9
x-ms-traffictypediagnostic: DM6PR10MB3244:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rIJf5lOgA/jGu3+DXprVzXqyo6fmexrrbUvA/5gSXQ+VVkxJ/vJ9x0A1Pao6TTOWwU3av9KSZ0GnueoPyPtspt6amiDHtf626FZmL4jR+TGz3DJDenMJuybzy++ylaSt/icIrvusU7GI/9u3SG6NZkErazZAM3OTcqZo6Jf9vKc//N6z84LtiS5VFRTb3tssvPxCVrXjyyWhdRmeu3UpfxE38MFdkyXu2AMJrDKINOKXb1E98/hmHUPb7E4Q4XnDom2aeL3hWBf3rSdJMOhRnQaeTsaLcHQ1eAMlJsBcAs51TMg5t+OOuhd3aswjSoRCTYUkhzGN7pUWR/HjvZsz6X6jjrlYm0r6u3tHizC1PdNeNC78FcbW/g8ZGEckqs89qGDrGu4rmqTN79GGFYR9P2gRUZeSre3sAoMOWU+IVsGiJl5zVEM5StX26AVMf3i4bmGafLEIRP3//oDJ2a/3OOWgvcIrD8UhgrncrsJaQHGEbhr38Mas1mT0E1HjB0miRiPgE/QWjd8kNaL8y3sFVkgrR3sT8ZdlfKoVH3ne4C9t3Uz6O1Rz1GZPtRmivdvvrQFLnzh1TYf6O7oDNwhidbmxKO0pD8uZiykHJuyjkdE00bZjGyJWoT/0PZVFDxf3RVHinKikchyiT54EMkb6ySNoBH08+p/T2o2mG0JmCul/wv7sVMA5IL1eS425dNJz6X1emeWjKYhp0bg+fGDbKwGDWzqw5Sai/PeQZ0k7dTxpLHUwAJxjOu21Y8gVGxH1pqkOgUVCw7Axz3my88zlqKzJnrZm/KCSnPvyIO1d6LOIY/qc7lsSTXzSaA1qPeBSOhIR+ZqS/V1+znUHDVtA9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(376002)(396003)(346002)(33656002)(86362001)(5660300002)(186003)(66946007)(38100700002)(6506007)(26005)(6512007)(2616005)(38070700005)(122000001)(2906002)(41300700001)(316002)(6916009)(6486002)(478600001)(8936002)(7116003)(71200400001)(91956017)(76116006)(36756003)(66556008)(66446008)(64756008)(66476007)(83380400001)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v8jYw2VF2uC1fi+8kicpGfi5+r/RptKtxWrTqZYOGB9gmyiXr540frti0PH3?=
 =?us-ascii?Q?rAyIPpMNsRjWdysZb+lzuSei4pJ5gBKW5X8OiF278ApZ69lMKhjo9hJilMeP?=
 =?us-ascii?Q?p0ICD4qpcpJ0bBufkg8OXU+9WredjGi6N6Bz6xndaBKQ9vfJiXXOq5PVKf4V?=
 =?us-ascii?Q?FL/scxxz7IcGPNcmy/LQx2AWu5ESNfQx/ksLRCQSh7OQ3fjx0+nRBuBKKcoL?=
 =?us-ascii?Q?kiO3qs/T01iSuxQheUT971NpnqMIADwZ+iJZqaPCed9spEeMY0pw6aXHjpNO?=
 =?us-ascii?Q?/SoZ4iZjNBsSovwUxWWICGd3Euuui5CXBsCqBvS1BjQhontkEwFmwn7QYfdQ?=
 =?us-ascii?Q?hQLWQKx5gIxYEQHDuyN/e+1pVCcU0epoaJw1W55K+KJ7TyRyPMF4Ub6SbghV?=
 =?us-ascii?Q?po6PMRLr2RaxRTLGPx1Z0t1dpvn+yu3ZmB7OqXSZFPtA9tTshgZhaor6np7Z?=
 =?us-ascii?Q?/3746zTG16PQGA7NCCA2/vOdEivI6bqYKNo3P6IXkhWI/ekLrCn8TpaKWUQT?=
 =?us-ascii?Q?V+FcpsugqOsLvx306Em6yVjnYDzwmmRVsmE68JN1KdsGwOyLKfQAFoV6Zcb5?=
 =?us-ascii?Q?mS4va8uEyPPMgKSXlDqFn/xepgg3X6cTtMFiPlIA4tAlbYsMejaZLcV05eZF?=
 =?us-ascii?Q?SLU6oWfA9Zd0TggSayf/ftsIDHOHNVZ90MECNPuRwrW3WaGvbTI8IuDrN1P7?=
 =?us-ascii?Q?7ILSchWIhnfi/5FLYMIq0Rf13BkTjnyYn5UgEnEV+TiyZtmUvMtecKpJS7d5?=
 =?us-ascii?Q?P3Gj7fHFVFdanai2XEMqj0Vt/tyIXkoiFLb8qo4CkGqN3IROcQjzRgcye3Jt?=
 =?us-ascii?Q?107JLjkk5bPRfF2YeexobhZdN57LL26uBbN8Tw8VBb+NKVircLXwi2R5/gW1?=
 =?us-ascii?Q?lha4qhb/YvIB44GLNyd4+Dr3qlCFulxxbMMt5DDtPxTaMieU3Y2I+bKeYwA9?=
 =?us-ascii?Q?IT1JZ/20th1FhA8UdtT06HLUSftpeB1bqmkpAHlv9yR4M60QileoKjuEgghA?=
 =?us-ascii?Q?Q0NaO8zBh/FCNlXOszDMAyZFxDr5zlWV54RBFx11ftU2rF1RrN1zWU7hRKpE?=
 =?us-ascii?Q?x5tT6i7T6ukwRLOett+KkNrFBSP3/Mk+khKZ6e2VC9Zy3ERNYi8X6yPzkybU?=
 =?us-ascii?Q?/QnG+Yb+ErXSIInkIa/gNLwxXiI8D6Fup6elAqiz/VfijVpiyRDSEM/DGIra?=
 =?us-ascii?Q?WGQr9ez+frNjt3RjcsKyb1MkEtlDNKnML1LR5y043BIFqAILYjLwXguHaOm2?=
 =?us-ascii?Q?ReT4s4xqACIzKbJzyPO6s6UrdkW9NeKfC3o/nt15FPy3AjSZJRdKl+IGWyWe?=
 =?us-ascii?Q?kVQCFH6CGSgE+1ZWrwqJXYKF3QafQgnIiowQTJKN2FQFwHZTQUEOTpBNgBfy?=
 =?us-ascii?Q?NDWaUWF8ukA5KMzFnM92EAWhmH9PHqPpf4nLcefJrsD6zl1pmfc6ZUwugWj4?=
 =?us-ascii?Q?Oqk0ljrYO6zPr7eCHnNWAmS+ELUdeByG6FB+2M9p+SCtWDPe7gVD78s/mmUW?=
 =?us-ascii?Q?kX8fxowlqjOA5Pi5xGUWV1Y6TJIjah3RB1L/RJDiHEhtbvj7yU+EDR/KjwAt?=
 =?us-ascii?Q?DNqu8OuhRy/wjtP1MmEn7UKEPvipECxcAJ5Jxq/japcsmNK556MvVN9tmPPe?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD8615898B079B40BC0C84FC76979F8B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0464478-3234-4ee6-1046-08da762d51f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 15:23:44.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mxK8lM4idoayW+ej/YUHuoxlLMOdSl/yALXkrupgMtYtpQ7s49QAFfwMR5gvf8hOzBNsJaPfKOpRdks/Pgg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040067
X-Proofpoint-ORIG-GUID: ly-atXkSz6igif7j0lPTfOhp7WIsHQ1_
X-Proofpoint-GUID: ly-atXkSz6igif7j0lPTfOhp7WIsHQ1_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

I'm running DELEG21 to unit-test delegations, and this message comes
out at the end:

Making sure b'DELEG21-1' is writable: operation OP_SETATTR should return NF=
S4_OK, instead got NFS4ERR_DELAY

I guess there's no callback service running during the test's clean-up phas=
e.

Then if I run the test again immediately:

[cel@morisot pynfs]$ sudo nfs4.0/testserver.py manet:/export/tmp --maketree=
 --rundeps -v cel
Initialization failed, no tests run.
Perhaps you need to use the --secure option or configure server to allow co=
nnections from high ports
Traceback (most recent call last):
  File "/home/cel/src/pynfs/nfs4.0/testserver.py", line 394, in <module>
    main()
  File "/home/cel/src/pynfs/nfs4.0/testserver.py", line 346, in main
    env.init()
  File "/home/cel/src/pynfs/nfs4.0/servertests/environment.py", line 150, i=
n init
    c.clean_dir(self.opts.path)
  File "/home/cel/src/pynfs/nfs4.0/nfs4lib.py", line 579, in clean_dir
    check_result(res, "Making sure %s is writable" % repr(e.name))
  File "/home/cel/src/pynfs/nfs4.0/nfs4lib.py", line 906, in check_result
    raise BadCompoundRes(resop, res.status, msg)
nfs4lib.BadCompoundRes: Making sure b'DELEG21-1' is writable: operation OP_=
SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY

And I think this condition persists until the old lease expires and
the server permits the client to delete that file.


--
Chuck Lever



