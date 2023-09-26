Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFA7AF1ED
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjIZRsp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRso (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 13:48:44 -0400
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (mail-dm3gcc02on2101.outbound.protection.outlook.com [40.107.91.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDD99F
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 10:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCUI9l6jQ8QLOopQthDv+dPFnADx10FOBUcGPRU7PhrLYHjjU1SygQnCg0Py6w5YJ4cR7XCX2F0nO9QeCeZ981g8uJmDs241s8qr1uvdsW89TrdZ3Q1My6bgNX3B/sT+n0a3gJm37NdZfAjqns6MU3OvRpZqmnGX7zYoQ2ARRIAoEWtwgZks9mDGUAM2u6hwYf9MnE1LetpXQqKB4r2zoheA/uIgpdF1ASwA1pamY+qIIPA6QwrPYCN6YmVFre3M1A2DsnNZzn6hA4Rq792p2x+nnUVOlWs9iY49Ljy7jnMEI78BHj9rAGZA7FP1+RCPzkqUECkBgWxt3Lhv6Og8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi1N8vRD5YrXRaIhxfV/+vd6+rBXB0AbLpewnU8iepU=;
 b=kMtHDhATepo7CUc2aAqGeUdne+M6nb5WBFdEM+0vh2zpt+sUvlQ0GuC+8PrugQtI8rL33FpvFPcD/4LC50sZfnZZHorWq8z4MAZVfOy/ZeXt2YVeLanKMOy2sClN1f7J7Y8tcFQ8zEdBmX4Yh7mMbqRxT21XxaT3K/QPRGG/1NW+U4g3tF110B+aloWyGu61LKTYzXYZZroNDjiq4KCO3501+cnpEjWmSbHo6eaRjUuHu/kdeZPCYGZ34f5z/OyFieCI4+f62QWi2a7evgjdnwWt9i4jxVeeMnZLx1S/1e0Yfa3pCkxTzUN88nz7fda31fTw8e0VvDwmayYD/953KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi1N8vRD5YrXRaIhxfV/+vd6+rBXB0AbLpewnU8iepU=;
 b=uD/euwMgkhljaBPFwHNlWXCeX3NAGmnEFQvllgkzR/ewlvPm19M6/sDv0EXA0AR47NEdhEqXa6NzIT4ihsgRLw8/FHf1RRwc9zR++3ehF8F0CoWzNHLYQlNi6ixd5WJ/w1I246RFQPYHe8AcF+CBWJwIzPWVhcQUDA0Xp+8J4EduQC57/H/fGqf6t5PdRdhgBDA7elU9TShSg83YcAC+NNYVDeWY39WxvZhwYVmp89yyGFpZMoP4ywsTyh+vmOX2sCqJk/979HWaE43jJF9FW11GWbOblM0bIoqpYKoRt6iaTqLoJfV0RHaFPMLa7SqGCOwQ/Q7X9NLLgBVjAppg3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com (2603:10b6:a03:26b::14)
 by DM8PR09MB6488.namprd09.prod.outlook.com (2603:10b6:5:2e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 17:48:34 +0000
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::e37a:a797:7414:1279]) by SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::e37a:a797:7414:1279%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 17:48:32 +0000
Message-ID: <84b65a4f-272c-69af-245a-423762491315@nwra.com>
Date:   Tue, 26 Sep 2023 11:48:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Orion Poplawski <orion@nwra.com>
Subject: Random operation not permitted / NFS4ERR_ENOENT messages
Organization: NorthWest Research Associates
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050706030206090403050603"
X-ClientProxiedBy: CYZPR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:930:8b::23) To SJ0PR09MB6318.namprd09.prod.outlook.com
 (2603:10b6:a03:26b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB6318:EE_|DM8PR09MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d73f55-7eec-4ab9-3c97-08dbbeb8cd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7seq7rUbL4n7Cs+SM/JVuUv0W78CQhr6zmZTGDDujqfr+oPNkzk+1PDRqUpf/ayHMmZKoP//L1bU17I3hO/MlWl2sU8C+l4upkRzH4kYJYC7NHWHwUIQzY7kR5poTWmsz/BGgvV60pwxFRuVImUys1/cVze5DVmSvN5XI2KM+L0nldqwwdE0NE2KedpeAk545Qsk7OnT3kzff/YixJGIC0wruBZmt5iGBSH1e+kJb6lPMka8FXoEOYtDsqx/IL6ZVodalXC62o5frxXcTyXfp+HPQwWXdtHpQezKUKLHZ1379cawhZE6ErCBPFu8b9+1mc8r92ordIixIvzKBbGyViDJaVwDLQClWju3fXnGwSdJdrTlydvqOti5tXYDsmrj+LSdVSXB8CAB7Z7xGI6YFgxsaLDDygIYN8wR2X8yWqoZez8Cz43F4uMMJl1piV30Dm3FrXPdhndkSprcNuuFfVpFS3L/xsdrRH0eqv03ufH4HU5JrU2u93s3COeX8BJcNNvIkO4DR89DriCSJosSV7nNr/qzpyRzqsvNr/Ekm+/+gOTKiJS29dJoPL0Z+ynqA+gGoSnY9V3FAaDdOvejvZN8HYZuVQXM2MSBykRiBlVyzFP5KzWA6xJApdQwnSG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB6318.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39830400003)(366004)(230922051799003)(1800799009)(186009)(451199024)(66946007)(235185007)(66574015)(6916009)(66556008)(83380400001)(31686004)(40140700001)(6486002)(36916002)(6666004)(6506007)(33964004)(2616005)(66476007)(26005)(36756003)(6512007)(966005)(41320700001)(5660300002)(8936002)(31696002)(508600001)(38100700002)(2906002)(86362001)(30864003)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGd0SThCckpYTmJQMVpKUE00bER2NGRmSEJQaHVDMGFraFBHUVBvY05CcGYw?=
 =?utf-8?B?MlF5MkpHeDFYclZmSUNVN1hVVzVIUTljb1V0b0s3ZzJod01rbmx5YW9aZWNN?=
 =?utf-8?B?alhjRjZXN1I2WUp3L3BscUIxbzVJNFFQa0EwMFBXb1NXeCtYSGFLcktjN0t0?=
 =?utf-8?B?N2RtdEc2T3kzc1ZPOHFQRDEwNFdOYXZhUm1GZXV6K2dibDNJeVhEMXI3THdn?=
 =?utf-8?B?WU1YNGVuNXlvT0xwS3M1dDJvTCtSeUljZUJsY2dEMnFPRWx6NGlXeDU1Ujhk?=
 =?utf-8?B?UlRhaU8yM3gwSGxWeGxSNFpEbDUzdi9CZFdHN0xscmdLRnRmNzZadXQvWXE5?=
 =?utf-8?B?czV0ekhCT1BBUzN3MHhUenBWcEp5TVF2alR2dXFXRUtQOUNVT0lSZXVFb1N2?=
 =?utf-8?B?aXdBM3MzWDVWbTAybGdtdmQxMTZEQ1RNSE1WaUR2cFZHMjJhTWgzZFVmREhr?=
 =?utf-8?B?L2llOVFlelllR25DTmlheThTNzZQcUFveUF2R09aNENNMmFLcGdkZXIzdEVV?=
 =?utf-8?B?L0pHd2padVVZSUtEOVhRM2gzbTV4cjNrYU5ZbnU1UWpmUFJrSFlJbHc0UDdt?=
 =?utf-8?B?eUFsZ0Vwek1RTUdRZlorS2VPVHFzWmU2Z3FBSExuWmMvYit4N2VhOHl2RFpn?=
 =?utf-8?B?VncyempCRFBoOE9OSWtRTDFHeWhsUDMzaHJER3lia0V3eGU4UTV0dHdiN2k5?=
 =?utf-8?B?K09jcnc0eC9DSEJOa1V0YnREU1NWNmRJOGViZHg2VnpETnB2eGpVVTEzQzRj?=
 =?utf-8?B?cmxkaU13eDhqN1BFZDFPejVRNjFVR1U2bkttTjhqWE1HTzhJZ0xwcjhjK2I5?=
 =?utf-8?B?RmZwLzRvYi9XaHkveERha0RRZmJLb0dGVmIweWw5cFhGR1NKMU9zVS9UcUtk?=
 =?utf-8?B?SUVXWXFNOW9RMFg5YXY1OWplUnI5U2llQkVyRGJ6YXhCZFZsakx1dmEvUkhF?=
 =?utf-8?B?QWN4SDZxNm9YZzVZMG1NVUFjS3dXR2RlTWVzT1MzeVZ0WDNzNFpHQ3RiTHNr?=
 =?utf-8?B?WnEzT3M0aEdDWFoyc1l5QVh4THkrd2dTQUg2MEJhZmMvMi9jYnY1L2ViYzZq?=
 =?utf-8?B?OGhqMzJXS0hnRDdYeE9UQ0JYdm5kNkJESzlaMkdEK1JmSlcyRGZUNlRSaDJi?=
 =?utf-8?B?cG0wbSsxd1cxblFDQ1RFLzltZFpsSUMxY0pGNzJCM1A5SXFBRUNuK013cmhE?=
 =?utf-8?B?SHZ0UnlNbEUyVmdYS0ZLdStMbnpDQmtocGtNM0lhYXYyUnJOSGs4a0c1K0Za?=
 =?utf-8?B?MjJHSW5hVXdodHliazhNVzJFRXFtVjVjSndCekFROEhCUDJWMktiRXZVSFB0?=
 =?utf-8?B?U0NtQW1HUmYvUmZUVzNsOXFORnpoaVBVYmFPUVBoRHZhT1U5SGh5SjRNdFNK?=
 =?utf-8?B?VW5XQmhKMVgxRGtDQkFZZmlBTnhGKzNHVmgvZ3RjOWdJSG5TcStGcWJtZEEz?=
 =?utf-8?B?MHcwcUNZUGIzTk9ZZXhIN3BsdGZXams2R2x4L3gyR0p2dCt4NENuSzk4K3U0?=
 =?utf-8?B?MVIwSGlrR01lVkphaFlpNVlYTlJxTDJIQjlqZm5GL2d6Vm1TOHZzOGJXTE0y?=
 =?utf-8?B?aVprNkFidEdVU0tBR2JYeUs2Mk1sUnRQeEg2Qm1IeS8zbDJGRGh2NlJrYVA1?=
 =?utf-8?B?RHVJZEpzUy9TeDJ5aVFFak5SeWdBV0RiOHg0N25wVVg0OGlPVEtYampYR3Nj?=
 =?utf-8?B?Qk1xSEFqbXJweWdmc1A3akhrejBTZzFYR0dwVmlGVW90L21QYUdoUzJtM1VR?=
 =?utf-8?B?ZjU5bHpSM3QwMVZ6ZVZ5NGFwOVpRWmFHeW5id3VFdDR3SkZEU3NQckc3c2JC?=
 =?utf-8?B?ZTJGY2RwL3BTLzM4NVJ4UXhoR00xSk1Md2NramRwUVA2QVhlVTJEZVVsaFBv?=
 =?utf-8?B?VGlYMndDcklrSDN1ektWazlqOXlhOXVHMDhjVytuazI1V0xVOEtsM0pxL3dq?=
 =?utf-8?B?WTF1LzQzdWR6ZkJ3U2FWL1JIK1RuNUpWU25lVEZia1pnUDdiOTBlOUhpLzJI?=
 =?utf-8?B?SEVwL2VPQ0FFTll2OGJpOWFZTVZFbURTalJiKzdKVDgwd3pJNEkrUzVNbTY4?=
 =?utf-8?B?WXJDVThRRmpLRzJYUk0vbXZLSG1QM1pLUzZ0aW9yYlpnbXJFN2tDQzlLVGNp?=
 =?utf-8?Q?qj4+iav2Y1LKKVuIoCR3P+iQQ?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d73f55-7eec-4ab9-3c97-08dbbeb8cd06
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB6318.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 17:48:32.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------ms050706030206090403050603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have seen some weird NFS issues in my days, but this one may top them 
all.  I have one EL9 client connecting to an EL7 server where I'm seeing 
random access issues:

$ wc -l scipy39-intel-*
    454 scipy39-intel-qcomp1.1
wc: scipy39-intel-qcomp2: Operation not permitted
    363 scipy39-intel-smmic1
    365 scipy39-intel-smmic1.1
   1182 total
$ wc -l scipy39-intel-*
    454 scipy39-intel-qcomp1.1
    435 scipy39-intel-qcomp2
    363 scipy39-intel-smmic1
    365 scipy39-intel-smmic1.1

Client:
nfs-utils-2.5.4-18.el9.x86_64
kernel-5.14.0-284.30.1.el9_2.x86_64
earthg.cora.nwra.com:/export/home/orion /home/orion nfs4 
rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=1,acregmax=1,acdirmin=1,acdirmax=1,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.133,lookupcache=pos,local_lock=none,addr=192.168.1.5 
0 0

Server:
nfs-utils-1.3.0-0.68.el7.2.x86_64
kernel-3.10.0-1160.99.1.el7.x86_64

/               -ro,async,fsid=0 192.168.1.0/24(sec=sys) 
192.168.2.0/24(sec=sys) 10.0.0.0/8(sec=krb5) *.nwra.com(sec=krb5)
/export/home    -rw,async,nohide 192.168.1.0/24(sec=sys) 
192.168.2.0/24(sec=sys) 10.0.0.0/8(sec=krb5) *.nwra.com(sec=krb5)

tshark reports the server returning NFS4ERR_NOENT:

Frame 41: 318 bytes on wire (2544 bits), 318 bytes captured (2544 bits) 
on interface 0
Ethernet II, Src: RealtekU_a9:d8:34 (52:54:00:a9:d8:34), Dst: 
Dell_4d:82:59 (00:24:e8:4d:82:59)
Internet Protocol Version 4, Src: 192.168.1.133 (192.168.1.133), Dst: 
192.168.1.5 (192.168.1.5)
Transmission Control Protocol, Src Port: gdoi (848), Dst Port: nfs 
(2049), Seq: 5329, Ack: 4625, Len: 264
Remote Procedure Call, Type:Call XID:0xef4cfdaf
Network File System, Ops(3): SEQUENCE, PUTFH, CLOSE
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     minorversion: 2
     Operations (count: 3): SEQUENCE, PUTFH, CLOSE
         Opcode: SEQUENCE (53)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002f7
             slot id: 0
             high slot id: 0
             cache this?: Yes
         Opcode: PUTFH (22)
             filehandle
                 length: 32
                 [hash (CRC-32): 0xefafdd27]
                 decode type as: unknown
                 filehandle: 
01000681c370d9f027664f269d1025f5132996603f233624...
         Opcode: CLOSE (4)
             seqid: 0x00000000
             stateid
                 [StateID Hash: 0x6ae3]
                 seqid: 0x00000001
                 Data: 1f100365e983952638000000
     [Main Opcode: CLOSE (4)]

Frame 42: 170 bytes on wire (1360 bits), 170 bytes captured (1360 bits) 
on interface 0
Ethernet II, Src: Dell_4d:82:59 (00:24:e8:4d:82:59), Dst: 
RealtekU_a9:d8:34 (52:54:00:a9:d8:34)
Internet Protocol Version 4, Src: 192.168.1.5 (192.168.1.5), Dst: 
192.168.1.133 (192.168.1.133)
Transmission Control Protocol, Src Port: nfs (2049), Dst Port: gdoi 
(848), Seq: 4625, Ack: 5593, Len: 116
Remote Procedure Call, Type:Reply XID:0xef4cfdaf
Network File System, Ops(3): SEQUENCE PUTFH CLOSE
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Status: NFS4_OK (0)
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     Operations (count: 3)
         Opcode: SEQUENCE (53)
             Status: NFS4_OK (0)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002f7
             slot id: 0
             high slot id: 9
             target high slot id: 9
             status flags: 0x00000000
                 .... .... .... .... .... .... .... ...0 = 
SEQ4_STATUS_CB_PATH_DOWN: Not set
                 .... .... .... .... .... .... .... ..0. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING: Not set
                 .... .... .... .... .... .... .... .0.. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED: Not set
                 .... .... .... .... .... .... .... 0... = 
SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ...0 .... = 
SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ..0. .... = 
SEQ4_STATUS_ADMIN_STATE_REVOKED: Not set
                 .... .... .... .... .... .... .0.. .... = 
SEQ4_STATUS_RECALLABLE_STATE_REVOKED: Not set
                 .... .... .... .... .... .... 0... .... = 
SEQ4_STATUS_LEASE_MOVED: Not set
                 .... .... .... .... .... ...0 .... .... = 
SEQ4_STATUS_RESTART_RECLAIM_NEEDED: Not set
                 .... .... .... .... .... ..0. .... .... = 
SEQ4_STATUS_CB_PATH_DOWN_SESSION: Not set
                 .... .... .... .... .... .0.. .... .... = 
SEQ4_STATUS_BACKCHANNEL_FAULT: Not set
                 .... .... .... .... .... 0... .... .... = 
SEQ4_STATUS_DEVID_CHANGED: Not set
                 .... .... .... .... ...0 .... .... .... = 
SEQ4_STATUS_DEVID_DELETED: Not set
         Opcode: PUTFH (22)
             Status: NFS4_OK (0)
         Opcode: CLOSE (4)
             Status: NFS4_OK (0)
             stateid
                 [StateID Hash: 0x6414]
                 seqid: 0x00000002
                 Data: 1f100365e983952638000000
     [Main Opcode: CLOSE (4)]

Frame 43: 326 bytes on wire (2608 bits), 326 bytes captured (2608 bits) 
on interface 0
Ethernet II, Src: RealtekU_a9:d8:34 (52:54:00:a9:d8:34), Dst: 
Dell_4d:82:59 (00:24:e8:4d:82:59)
Internet Protocol Version 4, Src: 192.168.1.133 (192.168.1.133), Dst: 
192.168.1.5 (192.168.1.5)
Transmission Control Protocol, Src Port: gdoi (848), Dst Port: nfs 
(2049), Seq: 5593, Ack: 4741, Len: 272
Remote Procedure Call, Type:Call XID:0xf04cfdaf
Network File System, Ops(5): SEQUENCE, PUTFH, LOOKUP, GETFH, GETATTR
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     minorversion: 2
     Operations (count: 5): SEQUENCE, PUTFH, LOOKUP, GETFH, GETATTR
         Opcode: SEQUENCE (53)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002f8
             slot id: 0
             high slot id: 0
             cache this?: No
         Opcode: PUTFH (22)
             filehandle
                 length: 32
                 [hash (CRC-32): 0x6fd1a280]
                 decode type as: unknown
                 filehandle: 
01000681c370d9f027664f269d1025f51329966086b50420...
         Opcode: LOOKUP (15)
             Name: .git
                 length: 4
                 contents: .git
         Opcode: GETFH (10)
         Opcode: GETATTR (9)
             Attr mask[0]: 0x0010011a (TYPE, CHANGE, SIZE, FSID, FILEID)
                 reqd_attr: TYPE (1)
                 reqd_attr: CHANGE (3)
                 reqd_attr: SIZE (4)
                 reqd_attr: FSID (8)
                 reco_attr: FILEID (20)
             Attr mask[1]: 0x00b0a23a (MODE, NUMLINKS, OWNER, 
OWNER_GROUP, RAWDEV, SPACE_USED, TIME_ACCESS, TIME_METADATA, 
TIME_MODIFY, MOUNTED_ON_FILEID)
                 reco_attr: MODE (33)
                 reco_attr: NUMLINKS (35)
                 reco_attr: OWNER (36)
                 reco_attr: OWNER_GROUP (37)
                 reco_attr: RAWDEV (41)
                 reco_attr: SPACE_USED (45)
                 reco_attr: TIME_ACCESS (47)
                 reco_attr: TIME_METADATA (52)
                 reco_attr: TIME_MODIFY (53)
                 reco_attr: MOUNTED_ON_FILEID (55)
     [Main Opcode: LOOKUP (15)]

Frame 44: 154 bytes on wire (1232 bits), 154 bytes captured (1232 bits) 
on interface 0
Ethernet II, Src: Dell_4d:82:59 (00:24:e8:4d:82:59), Dst: 
RealtekU_a9:d8:34 (52:54:00:a9:d8:34)
Internet Protocol Version 4, Src: 192.168.1.5 (192.168.1.5), Dst: 
192.168.1.133 (192.168.1.133)
Transmission Control Protocol, Src Port: nfs (2049), Dst Port: gdoi 
(848), Seq: 4741, Ack: 5865, Len: 100
Remote Procedure Call, Type:Reply XID:0xf04cfdaf
Network File System, Ops(3): SEQUENCE PUTFH LOOKUP(NFS4ERR_NOENT)
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Status: NFS4ERR_NOENT (2)
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     Operations (count: 3)
         Opcode: SEQUENCE (53)
             Status: NFS4_OK (0)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002f8
             slot id: 0
             high slot id: 9
             target high slot id: 9
             status flags: 0x00000000
                 .... .... .... .... .... .... .... ...0 = 
SEQ4_STATUS_CB_PATH_DOWN: Not set
                 .... .... .... .... .... .... .... ..0. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING: Not set
                 .... .... .... .... .... .... .... .0.. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED: Not set
                 .... .... .... .... .... .... .... 0... = 
SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ...0 .... = 
SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ..0. .... = 
SEQ4_STATUS_ADMIN_STATE_REVOKED: Not set
                 .... .... .... .... .... .... .0.. .... = 
SEQ4_STATUS_RECALLABLE_STATE_REVOKED: Not set
                 .... .... .... .... .... .... 0... .... = 
SEQ4_STATUS_LEASE_MOVED: Not set
                 .... .... .... .... .... ...0 .... .... = 
SEQ4_STATUS_RESTART_RECLAIM_NEEDED: Not set
                 .... .... .... .... .... ..0. .... .... = 
SEQ4_STATUS_CB_PATH_DOWN_SESSION: Not set
                 .... .... .... .... .... .0.. .... .... = 
SEQ4_STATUS_BACKCHANNEL_FAULT: Not set
                 .... .... .... .... .... 0... .... .... = 
SEQ4_STATUS_DEVID_CHANGED: Not set
                 .... .... .... .... ...0 .... .... .... = 
SEQ4_STATUS_DEVID_DELETED: Not set
         Opcode: PUTFH (22)
             Status: NFS4_OK (0)
         Opcode: LOOKUP (15)
             Status: NFS4ERR_NOENT (2)
     [Main Opcode: LOOKUP (15)]

Frame 45: 326 bytes on wire (2608 bits), 326 bytes captured (2608 bits) 
on interface 0
Ethernet II, Src: RealtekU_a9:d8:34 (52:54:00:a9:d8:34), Dst: 
Dell_4d:82:59 (00:24:e8:4d:82:59)
Internet Protocol Version 4, Src: 192.168.1.133 (192.168.1.133), Dst: 
192.168.1.5 (192.168.1.5)
Transmission Control Protocol, Src Port: gdoi (848), Dst Port: nfs 
(2049), Seq: 5865, Ack: 4841, Len: 272
Remote Procedure Call, Type:Call XID:0xf14cfdaf
Network File System, Ops(5): SEQUENCE, PUTFH, LOOKUP, GETFH, GETATTR
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     minorversion: 2
     Operations (count: 5): SEQUENCE, PUTFH, LOOKUP, GETFH, GETATTR
         Opcode: SEQUENCE (53)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002f9
             slot id: 0
             high slot id: 0
             cache this?: No
         Opcode: PUTFH (22)
             filehandle
                 length: 32
                 [hash (CRC-32): 0x6fd1a280]
                 decode type as: unknown
                 filehandle: 
01000681c370d9f027664f269d1025f51329966086b50420...
         Opcode: LOOKUP (15)
             Name: .git
                 length: 4
                 contents: .git
         Opcode: GETFH (10)
         Opcode: GETATTR (9)
             Attr mask[0]: 0x0010011a (TYPE, CHANGE, SIZE, FSID, FILEID)
                 reqd_attr: TYPE (1)
                 reqd_attr: CHANGE (3)
                 reqd_attr: SIZE (4)
                 reqd_attr: FSID (8)
                 reco_attr: FILEID (20)
             Attr mask[1]: 0x00b0a23a (MODE, NUMLINKS, OWNER, 
OWNER_GROUP, RAWDEV, SPACE_USED, TIME_ACCESS, TIME_METADATA, 
TIME_MODIFY, MOUNTED_ON_FILEID)
                 reco_attr: MODE (33)
                 reco_attr: NUMLINKS (35)
                 reco_attr: OWNER (36)
                 reco_attr: OWNER_GROUP (37)
                 reco_attr: RAWDEV (41)
                 reco_attr: SPACE_USED (45)
                 reco_attr: TIME_ACCESS (47)
                 reco_attr: TIME_METADATA (52)
                 reco_attr: TIME_MODIFY (53)
                 reco_attr: MOUNTED_ON_FILEID (55)
     [Main Opcode: LOOKUP (15)]

Frame 46: 154 bytes on wire (1232 bits), 154 bytes captured (1232 bits) 
on interface 0
Ethernet II, Src: Dell_4d:82:59 (00:24:e8:4d:82:59), Dst: 
RealtekU_a9:d8:34 (52:54:00:a9:d8:34)
Internet Protocol Version 4, Src: 192.168.1.5 (192.168.1.5), Dst: 
192.168.1.133 (192.168.1.133)
Transmission Control Protocol, Src Port: nfs (2049), Dst Port: gdoi 
(848), Seq: 4841, Ack: 6137, Len: 100
Remote Procedure Call, Type:Reply XID:0xf14cfdaf
Network File System, Ops(3): SEQUENCE PUTFH LOOKUP(NFS4ERR_NOENT)
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Status: NFS4ERR_NOENT (2)
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     Operations (count: 3)
         Opcode: SEQUENCE (53)
             Status: NFS4_OK (0)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002f9
             slot id: 0
             high slot id: 9
             target high slot id: 9
             status flags: 0x00000000
                 .... .... .... .... .... .... .... ...0 = 
SEQ4_STATUS_CB_PATH_DOWN: Not set
                 .... .... .... .... .... .... .... ..0. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING: Not set
                 .... .... .... .... .... .... .... .0.. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED: Not set
                 .... .... .... .... .... .... .... 0... = 
SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ...0 .... = 
SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ..0. .... = 
SEQ4_STATUS_ADMIN_STATE_REVOKED: Not set
                 .... .... .... .... .... .... .0.. .... = 
SEQ4_STATUS_RECALLABLE_STATE_REVOKED: Not set
                 .... .... .... .... .... .... 0... .... = 
SEQ4_STATUS_LEASE_MOVED: Not set
                 .... .... .... .... .... ...0 .... .... = 
SEQ4_STATUS_RESTART_RECLAIM_NEEDED: Not set
                 .... .... .... .... .... ..0. .... .... = 
SEQ4_STATUS_CB_PATH_DOWN_SESSION: Not set
                 .... .... .... .... .... .0.. .... .... = 
SEQ4_STATUS_BACKCHANNEL_FAULT: Not set
                 .... .... .... .... .... 0... .... .... = 
SEQ4_STATUS_DEVID_CHANGED: Not set
                 .... .... .... .... ...0 .... .... .... = 
SEQ4_STATUS_DEVID_DELETED: Not set
         Opcode: PUTFH (22)
             Status: NFS4_OK (0)
         Opcode: LOOKUP (15)
             Status: NFS4ERR_NOENT (2)
     [Main Opcode: LOOKUP (15)]

Frame 47: 326 bytes on wire (2608 bits), 326 bytes captured (2608 bits) 
on interface 0
Ethernet II, Src: RealtekU_a9:d8:34 (52:54:00:a9:d8:34), Dst: 
Dell_4d:82:59 (00:24:e8:4d:82:59)
Internet Protocol Version 4, Src: 192.168.1.133 (192.168.1.133), Dst: 
192.168.1.5 (192.168.1.5)
Transmission Control Protocol, Src Port: gdoi (848), Dst Port: nfs 
(2049), Seq: 6137, Ack: 4941, Len: 272
Remote Procedure Call, Type:Call XID:0xf24cfdaf
Network File System, Ops(5): SEQUENCE, PUTFH, LOOKUP, GETFH, GETATTR
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     minorversion: 2
     Operations (count: 5): SEQUENCE, PUTFH, LOOKUP, GETFH, GETATTR
         Opcode: SEQUENCE (53)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002fa
             slot id: 0
             high slot id: 0
             cache this?: No
         Opcode: PUTFH (22)
             filehandle
                 length: 32
                 [hash (CRC-32): 0x6fd1a280]
                 decode type as: unknown
                 filehandle: 
01000681c370d9f027664f269d1025f51329966086b50420...
         Opcode: LOOKUP (15)
             Name: HEAD
                 length: 4
                 contents: HEAD
         Opcode: GETFH (10)
         Opcode: GETATTR (9)
             Attr mask[0]: 0x0010011a (TYPE, CHANGE, SIZE, FSID, FILEID)
                 reqd_attr: TYPE (1)
                 reqd_attr: CHANGE (3)
                 reqd_attr: SIZE (4)
                 reqd_attr: FSID (8)
                 reco_attr: FILEID (20)
             Attr mask[1]: 0x00b0a23a (MODE, NUMLINKS, OWNER, 
OWNER_GROUP, RAWDEV, SPACE_USED, TIME_ACCESS, TIME_METADATA, 
TIME_MODIFY, MOUNTED_ON_FILEID)
                 reco_attr: MODE (33)
                 reco_attr: NUMLINKS (35)
                 reco_attr: OWNER (36)
                 reco_attr: OWNER_GROUP (37)
                 reco_attr: RAWDEV (41)
                 reco_attr: SPACE_USED (45)
                 reco_attr: TIME_ACCESS (47)
                 reco_attr: TIME_METADATA (52)
                 reco_attr: TIME_MODIFY (53)
                 reco_attr: MOUNTED_ON_FILEID (55)
     [Main Opcode: LOOKUP (15)]

Frame 48: 154 bytes on wire (1232 bits), 154 bytes captured (1232 bits) 
on interface 0
Ethernet II, Src: Dell_4d:82:59 (00:24:e8:4d:82:59), Dst: 
RealtekU_a9:d8:34 (52:54:00:a9:d8:34)
Internet Protocol Version 4, Src: 192.168.1.5 (192.168.1.5), Dst: 
192.168.1.133 (192.168.1.133)
Transmission Control Protocol, Src Port: nfs (2049), Dst Port: gdoi 
(848), Seq: 4941, Ack: 6409, Len: 100
Remote Procedure Call, Type:Reply XID:0xf24cfdaf
Network File System, Ops(3): SEQUENCE PUTFH LOOKUP(NFS4ERR_NOENT)
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Status: NFS4ERR_NOENT (2)
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     Operations (count: 3)
         Opcode: SEQUENCE (53)
             Status: NFS4_OK (0)
             sessionid: 1f100365e98395269619000000000000
             seqid: 0x000002fa
             slot id: 0
             high slot id: 9
             target high slot id: 9
             status flags: 0x00000000
                 .... .... .... .... .... .... .... ...0 = 
SEQ4_STATUS_CB_PATH_DOWN: Not set
                 .... .... .... .... .... .... .... ..0. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING: Not set
                 .... .... .... .... .... .... .... .0.. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED: Not set
                 .... .... .... .... .... .... .... 0... = 
SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ...0 .... = 
SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ..0. .... = 
SEQ4_STATUS_ADMIN_STATE_REVOKED: Not set
                 .... .... .... .... .... .... .0.. .... = 
SEQ4_STATUS_RECALLABLE_STATE_REVOKED: Not set
                 .... .... .... .... .... .... 0... .... = 
SEQ4_STATUS_LEASE_MOVED: Not set
                 .... .... .... .... .... ...0 .... .... = 
SEQ4_STATUS_RESTART_RECLAIM_NEEDED: Not set
                 .... .... .... .... .... ..0. .... .... = 
SEQ4_STATUS_CB_PATH_DOWN_SESSION: Not set
                 .... .... .... .... .... .0.. .... .... = 
SEQ4_STATUS_BACKCHANNEL_FAULT: Not set
                 .... .... .... .... .... 0... .... .... = 
SEQ4_STATUS_DEVID_CHANGED: Not set
                 .... .... .... .... ...0 .... .... .... = 
SEQ4_STATUS_DEVID_DELETED: Not set
         Opcode: PUTFH (22)
             Status: NFS4_OK (0)
         Opcode: LOOKUP (15)
             Status: NFS4ERR_NOENT (2)
     [Main Opcode: LOOKUP (15)]


I did switch the client from mounting with sec=krb5 to sec=sys.  Perhaps 
this has left the server in a bad state?

Any ideas what could be going wrong?  I've rebooted the client many 
times, but have not yet had the opportunity to reboot the server.

I've not yet been able to reproduce the issue on any other EL9 (or 
other) client.

-- 
Orion Poplawski
he/him/his  - surely the least important thing about me
IT Systems Manager                         720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms050706030206090403050603
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CmMwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggVGMIIELqADAgECAhEAyiICIp1F+xAAAAAATDn2WDANBgkqhkiG9w0B
AQsFADCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsT
MHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0G
A1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAy
IENsaWVudCBDQTAeFw0yMDEyMTQyMDQzMDlaFw0yMzEyMTUyMTEzMDhaMIGTMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEmMCQGA1UEChMd
Tm9ydGhXZXN0IFJlc2VhcmNoIEFzc29jaWF0ZXMxNTAWBgNVBAMTD09yaW9uIFBvcGxhd3Nr
aTAbBgkqhkiG9w0BCQEWDm9yaW9uQG53cmEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAxBJrIv9eGtrQLaU9pIGsIGBTiW0vZIYmz+5Eoa69sj6t6QANvg0IuVgWZajH
2fu8R+7m/AbZ8Wsuzz+ovtDHiVqUGvGzYyN9a5Ssx94SwNp9zLPfdCRMdh3zJB7gc4GYE/fA
kMkieO8u05f/hSyf9zU5gpjl7SW6p8IjkoyxNOr7KCbI4CQ3+1LG8pn6tz/QJwQ/BJZa4dE0
asXfNlZf5kZtyWtJhwub76zH5uXeODDxY3RooWj1l4V2fQCoFX2ov1ENUW4hRov1cMAD2QHJ
KL0Boir36wISvzq8Z65MSMCGNRiWwRaclVwVZ+QYnlhGZ0g6tMvxVrK+sHnxxr/LOwIDAQAB
o4IBfzCCAXswDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDBCBgNVHSAEOzA5MDcGC2CGSAGG+mwKAQQCMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly93d3cu
ZW50cnVzdC5uZXQvcnBhMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3AuZW50cnVzdC5uZXQwNQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0
OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5u
ZXQvY2xhc3MyY2EuY3JsMBkGA1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaA
FAmRpbrp8i4qdd/Nfv53yvLea5skMB0GA1UdDgQWBBSpChQTknhqMfb9Exia9G14q4j9ZzAJ
BgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQA15stihwBRGI8nFvZZalsmOHR954D+vrOZ
7cC0kl9K+S9u8j/E5nZd+A6PTKoDpAEYmPUYpe45tZLblnvfJC0yovSIIMTo1z3mRzldHYAt
ttjShH+M6s3xrqDtHfNAwt3TCf6H83sEpBi6wtbALfkIjKuDitgkdZsyUURoeglaaqVRhi2L
5wOOChQAyfsumjT1Gzk9qRtiv8aXzWiLeVKhzRO7a6o0jSdg1skyYKx3SPbIU4po/aT2Ph7V
niN0oqJHI11Fg6BfAey12aj5Uy96ztotiZRQuhWZPOc4d3df2N8RsdWViBp4jXt2hQjNr0Kw
pUPWRO/PENBVS1Uo1oXfMYIEYjCCBF4CAQEwgbswgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQK
Ew1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29y
cG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4x
IjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7EAAAAABMOfZY
MA0GCWCGSAFlAwQCAQUAoIICdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMzA5MjYxNzQ4MjlaMC8GCSqGSIb3DQEJBDEiBCDQJrVjkcqD77e0oImAgrMO
875FiJUPzttlP7bl2nOqujBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMIHMBgkrBgEEAYI3EAQxgb4wgbswgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7
EAAAAABMOfZYMIHOBgsqhkiG9w0BCRACCzGBvqCBuzCBpTELMAkGA1UEBhMCVVMxFjAUBgNV
BAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5j
b3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5j
LjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIRAMoiAiKdRfsQAAAAAEw5
9lgwDQYJKoZIhvcNAQEBBQAEggEAki0JhlHYJMwuZFQbM5FWMCUzAnuSK3ziI8hMTzzxCaIO
76RJCMaSj4KIS6KDZ9isJ0D2ZHzr1FrgibWrlPHfl74TcsGX+IptHDXYgTcxEYodjq+sv7jH
rNulJEylNOio8xbz+OUw1kSF1EjVTRxpT2W/4nCLZhnwo5P+sSh9NlRs5kZ120JYlsdjTJj9
E+9ZIDssfSCQDu3prQBGhf96rw6HlqKkydsuBYfa5Pc7hq6xMhnfneRQ0QYxy08tf9InUNAC
KkXej0/DXOZWJ8tRMm0/a04JX5bfhUVeI1DGK5r0LNRPtPqej8PCwYzQzUyjYeXsP7DO1tbX
BUq2VHT1OQAAAAAAAA==

--------------ms050706030206090403050603--
